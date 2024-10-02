Return-Path: <stable+bounces-79406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2A98D817
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EEC2814E5
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A90E1D07BA;
	Wed,  2 Oct 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="168XBQKI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867C1D0973;
	Wed,  2 Oct 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877356; cv=none; b=Nr+Ts1N6XqqGZ4kb9VDjy6jn5zM9j20DJUjiVlUmSq51zV/ZFshyRUF6lvI4dRTnykqj2tXCoKAXw8nT5MTztGg0P5Vg2MOuK+sDdy6sHBHfSW6AVppOuETU10624wz7BfbRo56jQC6ydJxLUKoW0HKi0S98EII3fpALBxopatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877356; c=relaxed/simple;
	bh=J8AxghBmY8IUPD8hmPincK1J2INIsLEelwGnSAjjcG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+Sf+JadiNzN4DLgr493ZjO9ZXMRzUgbXVONR45hHR0mnFg+L9kt7mnaBFzeeHU2oqx50iK1W3PbKjWcvPHombdJcZ/KhgbQQpEA6KvwwTEn8JJBQaKV/aMv0KmV44k8nL2q935kwRdniFL35FMow2TRKJGN/jewUHizmi8+iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=168XBQKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331E2C4CECD;
	Wed,  2 Oct 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877355;
	bh=J8AxghBmY8IUPD8hmPincK1J2INIsLEelwGnSAjjcG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=168XBQKIE2EAKPMVlbNJ8KdA5jh0OZlkdyFzOoSGWVez2I8egNqrWK1+yUamfDOLl
	 qiu4/sMdpwiW4T2kbA6Ba8pVcgsj43eR9GbA4ArUxhU2VqflZcHUX8kcdlIz4aFNi7
	 WvrseVUM0jNzguEy1reAV10rGxMmUY2haOyAIcjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 053/634] netfilter: nf_tables: elements with timeout below CONFIG_HZ never expire
Date: Wed,  2 Oct 2024 14:52:33 +0200
Message-ID: <20241002125813.198021242@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e0c47281723f301894c14e6f5cd5884fdfb813f9 ]

Element timeout that is below CONFIG_HZ never expires because the
timeout extension is not allocated given that nf_msecs_to_jiffies64()
returns 0. Set timeout to the minimum value to honor timeout.

Fixes: 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23 days")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 41d7faeb101cf..ebf8d4cbbdc35 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4544,7 +4544,7 @@ int nf_msecs_to_jiffies64(const struct nlattr *nla, u64 *result)
 		return -ERANGE;
 
 	ms *= NSEC_PER_MSEC;
-	*result = nsecs_to_jiffies64(ms);
+	*result = nsecs_to_jiffies64(ms) ? : !!ms;
 	return 0;
 }
 
-- 
2.43.0




