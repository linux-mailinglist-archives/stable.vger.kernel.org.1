Return-Path: <stable+bounces-79903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A654198DAD3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FAD1C232E8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81C1D0E1A;
	Wed,  2 Oct 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kS30DdHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D371D0797;
	Wed,  2 Oct 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878805; cv=none; b=T/3NHpg+0Kx9497zzVRKA1J1ObzLjbchHhcOpV3/bZlSTdApYFxITIcLT8k7oUFwX9ywDENhs8Q3lCm8fO/j6wQtyAB4lIBKWE4pcy1Lg/WPfnTpyYRIkKTaRPn7FOAOITlkd6BV723Yv9Zn04HQvNJBRpAlScMRLhinkD4M5xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878805; c=relaxed/simple;
	bh=wjvZ2u0o39eHTVxvZfp1yjupEv591zuAntKsrcSsOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUvBIl2LTagmRIamS9av5w8wGzSKuandK+WegHIOwpNWEkPtklB7tBKZWJmMmLo9QsVUxl21pax5z7W64k0+O1ICDcDh4lt0TRqwWCuvsSswskNsxkqiQFRswE5OJ2n+MoRBwqnTE1v7Fwv1kjVe6Fp7I50PSjgSyH+yoSnjSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kS30DdHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E0C4CEC2;
	Wed,  2 Oct 2024 14:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878805;
	bh=wjvZ2u0o39eHTVxvZfp1yjupEv591zuAntKsrcSsOEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kS30DdHi1GNpeuWY+90pKn8XVAOgd9P+8g9johB63TWu8gWE874IpL94K+MXG5Jeb
	 zLVNqVkeyG6V6+dd2uNVhnJahulAfFV6amtS2ur384d/IKfy6w8XT2GFyZOJ76RMfC
	 8b7rMsEnBU9rQChjn+f5YUa69xcDnpqCogjeNBZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6.10 507/634] ata: libata-scsi: Fix ata_msense_control() CDL page reporting
Date: Wed,  2 Oct 2024 15:00:07 +0200
Message-ID: <20241002125831.117949197@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 0e9a2990a93f27daa643b6fa73cfa47b128947a7 upstream.

When the user requests the ALL_SUB_MPAGES mode sense page,
ata_msense_control() adds the CDL_T2A_SUB_MPAGE twice instead of adding
the CDL_T2A_SUB_MPAGE and CDL_T2B_SUB_MPAGE pages information. Correct
the second call to ata_msense_control_spgt2() to report the
CDL_T2B_SUB_MPAGE page.

Fixes: 673b2fe6ff1d ("scsi: ata: libata-scsi: Add support for CDL pages mode sense")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2358,7 +2358,7 @@ static unsigned int ata_msense_control(s
 	case ALL_SUB_MPAGES:
 		n = ata_msense_control_spg0(dev, buf, changeable);
 		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
-		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2A_SUB_MPAGE);
+		n += ata_msense_control_spgt2(dev, buf + n, CDL_T2B_SUB_MPAGE);
 		n += ata_msense_control_ata_feature(dev, buf + n);
 		return n;
 	default:



