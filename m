Return-Path: <stable+bounces-249066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODICKhVhCWpOXgQAu9opvQ
	(envelope-from <stable+bounces-249066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 08:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7B55F826
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E508B3012CE5
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 06:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011A92DB780;
	Sun, 17 May 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="q5SSwdCy"
X-Original-To: stable@vger.kernel.org
Received: from cvsmtppost03.nm.naver.com (cvsmtppost03.nm.naver.com [114.111.35.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A232D8DA8
	for <stable@vger.kernel.org>; Sun, 17 May 2026 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999567; cv=none; b=aygaRNZ94/7++NVCZwAUWW1J4nKXlchheO96+g5H6kzaDS9Np6a8m47pF8wrs8Q7SVH9e1XfwECUjuTAXNkDwpgNRy+8ghbA74yFCrYWPR9xv9imqIpNWmDrdin8Mtfhcy156NiGokAQ7K7/6FWUmYcNF7L3rS4C5kPSwSBYc5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999567; c=relaxed/simple;
	bh=EUmxwMrXZ0cwf1j8lx2HZkA1cEuoNvq7xjtIstY5bQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3Ji7GFmxgd32bz/AxwlTfWmYykJCvEwyNkWA3n6mG6MQKs/VFZzH8AoNBDelpKbXi3mczafpvZKoE7vREljxjot74Gy6id9JF0ye8Mc6W3yCuUuoVZNeKRIwtdA4ubsjTnFHe8Gl+hxro7rX2eFa4VSFqZRXok3kbpRVtgqa5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=q5SSwdCy; arc=none smtp.client-ip=114.111.35.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Received: from cvsendbo027.nm ([10.112.22.36])
  by cvsmtppost03.nm.naver.com with ESMTP id ClCj16LHRc6PN4bHX7xJMA
  for <stable@vger.kernel.org>;
  Sun, 17 May 2026 06:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1778998956; bh=EUmxwMrXZ0cwf1j8lx2HZkA1cEuoNvq7xjtIstY5bQ4=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=q5SSwdCyC2uDY8yMSfIx/AZ1g+miBICPlaHZHRO6usGRSKK+DUaxdOm/aZhBxY9fd
	 u8fhHqRilKrxUk6ERyGvmVOmGaFNXMLfKSRSTZI8Tam2bEILreymsNoAsiK7H8o239
	 W0F5DO9CVN9nVLZ/Ltxlebypv4+psFPPjkRo/KN/10C42iH49PJ9AcHQDae5DDOMJA
	 +cGZ2f5iwFGf5RUZcqmA6gTrw+TIK51EZ8F/5auikf2lfo34aXe/OtCoZ6I7v3cTnb
	 dZVTDcUhu470upou8elTk4N2ulwJQ6nHTdO0GeCZRGYST5DBgWnm8qV+bQwFtqlNkN
	 HavKLWG9yjOFA==
X-Session-ID: x5c5JD1aQqKZhmW--jKxrw
X-Works-Send-Opt: pQb/jAJYjHmdKoUqFxJYaAU/aHwtxBmwjAg=
X-Works-Smtp-Source: zdnrax2XFqJZ+HmrFxEr+6E=
Received: from DESKTOP-PE9G5L9.localdomain ([1.219.165.140])
  by cvnsmtp004.nm.naver.com with ESMTP id x5c5JD1aQqKZhmW--jKxrw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sun, 17 May 2026 06:22:36 -0000
From: Heechan Kang <gganji11@naver.com>
To: Brett Creeley <brett.creeley@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Heechan Kang <gganji11@naver.com>
Subject: [PATCH] fwctl: pds: Validate RPC input size before parsing
Date: Sun, 17 May 2026 15:22:32 +0900
Message-Id: <20260517062232.1858747-1-gganji11@naver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DA7B55F826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[naver.com,none];
	R_DKIM_ALLOW(-0.20)[naver.com:s=s20171208];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249066-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,kernel.org,linuxfoundation.org,vger.kernel.org,naver.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[naver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[naver.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gganji11@naver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The fwctl core allocates the device-specific RPC input buffer with
fwctl_rpc.in_len and passes that buffer to the driver callback.

pdsfc_fw_rpc() casts the buffer to struct fwctl_rpc_pds and then calls
pdsfc_validate_rpc(), which reads fields from that structure before
checking that the input buffer is large enough to contain it. A short
in_len can make pds_fwctl read beyond the allocation.

Reject pds RPC buffers that are smaller than struct fwctl_rpc_pds before
parsing any pds-specific fields.

Fixes: 92c66ee829b9 ("pds_fwctl: add rpc and query support")
Cc: stable@vger.kernel.org # v6.15+
Signed-off-by: Heechan Kang <gganji11@naver.com>
---
 drivers/fwctl/pds/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fwctl/pds/main.c b/drivers/fwctl/pds/main.c
index 08872ee8422f..68fe254dd10a 100644
--- a/drivers/fwctl/pds/main.c
+++ b/drivers/fwctl/pds/main.c
@@ -362,6 +362,9 @@ static void *pdsfc_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
 	void *out = NULL;
 	int err;
 
+	if (in_len < sizeof(*rpc))
+		return ERR_PTR(-EINVAL);
+
 	err = pdsfc_validate_rpc(pdsfc, rpc, scope);
 	if (err)
 		return ERR_PTR(err);
-- 
2.34.1


