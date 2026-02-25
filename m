Return-Path: <stable+bounces-218154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOxvAAJRnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213A218EE1D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 858E03078BE6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416B242D9B;
	Wed, 25 Feb 2026 01:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQebHmcS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5851D5ABA;
	Wed, 25 Feb 2026 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982937; cv=none; b=QeagwsKoOoMIbE0NMVFPLPG3YjZEPfi1sqVfSEXYPXYKSxkvWBEm0EOMYmlk0v+Ec65ldAB27CmS1simfInDuOwmhbootc9xteGarbBM2Rnq/e3/IYyazsUAPHKVkadDN2Y7r8P16/xZhhmVSUMk4JHbZ9+h25eyJjT2kZoJAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982937; c=relaxed/simple;
	bh=0auOCzo/nvJWrE2GFS3/ylijvMSRuuVRCGWaoesfk00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVbnMD82n72Qa2KLmWp6d5RNyoLjDP1UGMRxYZ/SjfBMISyKarMMBRxDsRMHpeWPFRc56+y5HN8PJCUtj8PONF3VspEiE553dY17vIswpG97jTkNYvstv/eT58ZStcbXhUTVS7j3+s5PxYHWWbaTEQV67WfQgOoB4++CTuswJck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQebHmcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9567BC116D0;
	Wed, 25 Feb 2026 01:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982937;
	bh=0auOCzo/nvJWrE2GFS3/ylijvMSRuuVRCGWaoesfk00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQebHmcSGo9RyD0gAbX9Y43H+CTJDdEl8snj5oNKweOIJNCkQVTGKSFROCh2wo1Xs
	 xXqKfJ9Z4pD6qTozVWYAQYzmsmVe2C14rj/QQ1icxbriXmtfPL7CxzUmg1v+SHhxOU
	 d90KuD59Z23W8p8ml/3q2NVW4G+O4togNlKGZ73k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 071/781] crypto: qat - fix warning on adf_pfvf_pf_proto.c
Date: Tue, 24 Feb 2026 17:13:00 -0800
Message-ID: <20260225012401.444623200@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-218154-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 213A218EE1D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

[ Upstream commit 994689b8f91b02fdb5f64cba2412cde5ef3084b5 ]

Building the QAT driver with -Wmaybe-uninitialized triggers warnings in
qat_common/adf_pfvf_pf_proto.c. Specifically, the variables blk_type,
blk_byte, and byte_max may be used uninitialized in handle_blkmsg_req():

  make M=drivers/crypto/intel/qat W=1 C=2 "KCFLAGS=-Werror" \
       KBUILD_CFLAGS_KERNEL=-Wmaybe-uninitialized           \
       CFLAGS_MODULE=-Wmaybe-uninitialized

  ...
  warning: ‘byte_max’ may be used uninitialized [-Wmaybe-uninitialized]
  warning: ‘blk_type’ may be used uninitialized [-Wmaybe-uninitialized]
  warning: ‘blk_byte’ may be used uninitialized [-Wmaybe-uninitialized]

Although the caller of handle_blkmsg_req() always provides a req.type
that is handled by the switch, the compiler cannot guarantee this.

Add a default case to the switch statement to handle an invalid req.type.

Fixes: 673184a2a58f ("crypto: qat - introduce support for PFVF block messages")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c
index b9b5e744a3f16..af8dbc7517cf8 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pfvf_pf_proto.c
@@ -148,6 +148,16 @@ static struct pfvf_message handle_blkmsg_req(struct adf_accel_vf_info *vf_info,
 		blk_byte = FIELD_GET(ADF_VF2PF_SMALL_BLOCK_BYTE_MASK, req.data);
 		byte_max = ADF_VF2PF_SMALL_BLOCK_BYTE_MAX;
 		break;
+	default:
+		dev_err(&GET_DEV(vf_info->accel_dev),
+			"Invalid BlockMsg type 0x%.4x received from VF%u\n",
+			req.type, vf_info->vf_nr);
+		resp.type = ADF_PF2VF_MSGTYPE_BLKMSG_RESP;
+		resp.data = FIELD_PREP(ADF_PF2VF_BLKMSG_RESP_TYPE_MASK,
+				       ADF_PF2VF_BLKMSG_RESP_TYPE_ERROR) |
+			    FIELD_PREP(ADF_PF2VF_BLKMSG_RESP_DATA_MASK,
+				       ADF_PF2VF_UNSPECIFIED_ERROR);
+		return resp;
 	}
 
 	/* Is this a request for CRC or data? */
-- 
2.51.0




