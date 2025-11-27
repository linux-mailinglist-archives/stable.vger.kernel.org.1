Return-Path: <stable+bounces-197220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D896CC8EF20
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0443B7842
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9E312807;
	Thu, 27 Nov 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrHXazOG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E0312838;
	Thu, 27 Nov 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255132; cv=none; b=LTatS4ASC/gSqjZxnhKCc8a7VGzYS/x9pQv48Ugm2yaLrFtZoxOPsxMXRYyc7zAyO0MxTKYeEAor4fY3AphuPiWeWK+pD7N1hPKqshs9OuLxyOWbD3tTVLzlDQX0MQaoJQMKSkzR//pF6Ryr27dto3sbPIEWhQUisMpoj6uf0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255132; c=relaxed/simple;
	bh=9Qd/1i1zofhqF58IJOoDzBgFUcSNQoIomxioBthPxqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4AKZLkCdyndkawofqaLmbiy33IIZ2MKNROpXTQlCPHH97YaJOi6gD7O93PjV6yP7nWel+svHlHXRfclXix13hF1xqAXgRyJIqIfuj1apjBWJ+u++/mjDUQert2FI7UTsxmsfmSLDZQdMS6R/ZRfWxss/cng1unZe7zM5WjCUVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrHXazOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862A1C113D0;
	Thu, 27 Nov 2025 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255131;
	bh=9Qd/1i1zofhqF58IJOoDzBgFUcSNQoIomxioBthPxqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrHXazOG/Wid9HPnEOyJJ+Cv3y0PTorp0/LacKtcOTv8eaiWJtzEMtq/UwJIhDzNL
	 ie9kuvZTlkJat9uxDCu/FiCXVzWaH3ZOySTUtd8ZPKnm2nBNB41TNr6z/uQ/ByY5u9
	 BG/YHxrqVggkNa67URsO/Ay07/jhNVG0Kb0R9vgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yihang Li <liyihang9@h-partners.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.12 019/112] ata: libata-scsi: Add missing scsi_device_put() in ata_scsi_dev_rescan()
Date: Thu, 27 Nov 2025 15:45:21 +0100
Message-ID: <20251127144033.437358315@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144032.705323598@linuxfoundation.org>
References: <20251127144032.705323598@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yihang Li <liyihang9@h-partners.com>

commit b32cc17d607e8ae7af037303fe101368cb4dc44c upstream.

Call scsi_device_put() in ata_scsi_dev_rescan() if the device or its
queue are not running.

Fixes: 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yihang Li <liyihang9@h-partners.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-scsi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4807,8 +4807,10 @@ void ata_scsi_dev_rescan(struct work_str
 			spin_unlock_irqrestore(ap->lock, flags);
 			if (do_resume) {
 				ret = scsi_resume_device(sdev);
-				if (ret == -EWOULDBLOCK)
+				if (ret == -EWOULDBLOCK) {
+					scsi_device_put(sdev);
 					goto unlock_scan;
+				}
 				dev->flags &= ~ATA_DFLAG_RESUMING;
 			}
 			ret = scsi_rescan_device(sdev);



