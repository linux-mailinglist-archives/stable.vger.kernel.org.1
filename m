Return-Path: <stable+bounces-235168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF5RIsCr1mmZHAgAu9opvQ
	(envelope-from <stable+bounces-235168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68C3C2F59
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C3FA3201B54
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35ED3C5552;
	Wed,  8 Apr 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvRGDCC0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A73176E4;
	Wed,  8 Apr 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674744; cv=none; b=HFn2M3ljdzsZ4fC0gely7WLTG5+/mN5QjIcfoRGf7Wt0tIiGFgxuBaffLetb2vVevHcl6fyEQmaC3d2GeITOo+TV0muFTmEIX0FVT9EVlusepbJcSATYQ6MhcYTsBbTGjJDBw4+E20dio7080Bbcx25hVtgk4XdaLjKL9u83tAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674744; c=relaxed/simple;
	bh=D1Ao+C2LKcBpYRQQafRPHKvcS3fJbLuTAEOApojuBNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dboq/0d+i/U2t4yTplJ5nygeT4VIYbFSxxOJyaH6R9w3Bl1npTItlQyATPDKTPM33S0RgjZAeMfT0aEjuDCx0LRXqAbFERCmqO1OSAKqS7y3lk3n9dVlKSaxHBCShifNkrmqYOUZbeQPyqylW03p6f1GwVGVpLa/DHhkodN1vZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvRGDCC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAAFC19421;
	Wed,  8 Apr 2026 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674744;
	bh=D1Ao+C2LKcBpYRQQafRPHKvcS3fJbLuTAEOApojuBNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvRGDCC0MA4LV27HIYr3LyPFmQQe6cBFR8CMtZ6naSD8xYXo57GVenzYAQvj/8M3/
	 aOBIFbUvieU92PdY02Wf7cV0kkgnonXYwa/3+ZS/txAVCm7JcKcrpQGwyjOrAZ4Pdx
	 caKVnRj9AT8w4W+wtnGea9YpWNsr8Agr3z/AhwBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 217/311] iio: adc: ade9000: fix wrong return type in streaming push
Date: Wed,  8 Apr 2026 20:03:37 +0200
Message-ID: <20260408175947.506547771@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,analog.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-235168-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 0D68C3C2F59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>

commit 57b207e38d414a27fda9fff638a0d3e7ef16b917 upstream.

The else branch of ade9000_iio_push_streaming() incorrectly returns
IRQ_HANDLED on regmap_write failure. This function returns int (0 on
success, negative errno on failure), so IRQ_HANDLED (1) would be
misinterpreted as a non-error by callers.

Return ret instead, consistent with every other error path in the
function.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Reviewed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ade9000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -787,7 +787,7 @@ static int ade9000_iio_push_streaming(st
 				   ADE9000_MIDDLE_PAGE_BIT);
 		if (ret) {
 			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
-			return IRQ_HANDLED;
+			return ret;
 		}
 
 		ade9000_configure_scan(indio_dev, ADE9000_REG_WF_BUFF);



