Return-Path: <stable+bounces-218887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOu8N79XnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:00:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F791905C9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD60530DB18E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5C023D7CF;
	Wed, 25 Feb 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVHGw7ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706DD26E6F4;
	Wed, 25 Feb 2026 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983775; cv=none; b=VyOW2AMWRCuLPRqWZOogb6icEFKWKX+BgKhM5EFzjkDNLbN5D+hJD/2sErMDlyGcHrKzvT4WEWf1ZmxEQKxQkT3eu8cEyH7Pao0Kbq+RJrOs5dasu31OgMLzGa0RYNZSeo9caSOJH4fArXJ/1BovW0+nvZ+JpebSfk/5HM0YCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983775; c=relaxed/simple;
	bh=B1oi9+tCvxcLQ81cWgvFak73rYRzzMn8+pB4rhkdd40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrUb/Yd+abuXPQg+SOHAbI9cfWvXK7pl9OEUfBx8Rv0VZf/ks8Ps49i760uyRJdjlvnAouqGBPLy4T4jL1pK3vvgxuHXaihcd7S8ViQLR2NTjSbI3iA6aspAR2GcQhlfDFFtlUThx7JU0xJwcPADtstvrGje2zZVxFILSty2LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVHGw7ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27811C19423;
	Wed, 25 Feb 2026 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983775;
	bh=B1oi9+tCvxcLQ81cWgvFak73rYRzzMn8+pB4rhkdd40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVHGw7acBCpmC9Yps+yJqQDkgb9IMaRWa6j3PBCbIUK8xENgOXRhU5YS2VofZxt7W
	 5+cIzNSJKZeBXodRq5CDtqx+/rUjW6r92Npwy8yunB47Wt5XIY6hX2XAh8jq9vT37d
	 B2oxLdkwk+n+vwMiU+mlGKn2nHwQ7STtPSuInzqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 065/641] crypto: qat - fix warning on adf_pfvf_pf_proto.c
Date: Tue, 24 Feb 2026 17:16:31 -0800
Message-ID: <20260225012350.630535580@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218887-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,req.data:url,intel.com:email,apana.org.au:email,resp.data:url]
X-Rspamd-Queue-Id: 11F791905C9
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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




