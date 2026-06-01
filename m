Return-Path: <stable+bounces-259645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPQBDY7RHWowfAkAu9opvQ
	(envelope-from <stable+bounces-259645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:38:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CB6241B6
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0522F3007F41
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858443EB810;
	Mon,  1 Jun 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfW8KwYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7E3EA94A;
	Mon,  1 Jun 2026 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337982; cv=none; b=FFfdjTD32Lr4kvAicA2qH7B5qBkEbuGkSi0XBq/boyL2qZ/WGp8fEzB4B9sgAbatRhqlqmPt35pDp6JaGWj7kr6keyx2ieUp8p3epFE4H09wU2dz8LnHNPYBkM2wdGD9/3y8LhL3xdgD04VwmmWiLDZ9xd4I0EoC97RFfK3pIxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337982; c=relaxed/simple;
	bh=QjBMIRMZN/g/91XdQcuDoE20n5kH3fAOqHIOTHrvVzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aequePsqc8z9vvibt+CgkJke6ZdHY57SbTGa1d2o20EVEEYth994tehRyl6BI+AZms8T6oM7SleGuSgBhIEBdgEjtTrLP3ZcOJs47MoQvK5r0KNkGIDzzESkauEkFLLW3Bu7l+IdXhXveUxsXehSpyH+xsHJS/N1zHf+kpMiXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfW8KwYb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5AE1F00898;
	Mon,  1 Jun 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337981;
	bh=I2LpF/tG4HahngtW+id3yAeaupq32SdBcgxHz8GWLoI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BfW8KwYbdsyKE+pTHy2bIGPYEcW595LxmmGDT6y3dd/pvAFzeZo1sFxYcdpuqNg4Q
	 A3fSSOfYluV1VZCHSpA9SU6jZY7E1rZp48+l2bvIRb9iPXQUJ+bcxlFBAJqFqgSn03
	 me6ikeB00CUjs+31i0tsumMkw8Mw1CD2b10F1lFCBv820+EGDZ2GjzZdg7lVHIwLiX
	 iKHSt9I1DPTnzaXkUOU9kDVxpAWKnRZcFK/FahaAYQAjcI4Dz8CkzCpObLaBVpVPqU
	 wFB0GlEEyyiFno/VA/2FelcL+SDKv2ulr+S3DgFOuyFkWaKA/0y81f0v+Lb/FGz8+V
	 P5KTsO3VjKMJw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
 Jinmo Yang <jinmo44.yang@gmail.com>
Cc: jikos@kernel.org, stable@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
In-Reply-To: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
References: <20260601134124.1560886-1-jinmo44.yang@gmail.com>
Subject: Re: [PATCH v2 0/2] HID: wacom: fix sleeping in atomic context in
 wacom_wac_queue_flush()
Message-Id: <178033797980.14352.14268761542776534428.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:19:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259645-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8E4CB6241B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 01 Jun 2026 22:41:22 +0900, Jinmo Yang wrote:
> wacom_wac_queue_flush() uses GFP_KERNEL for kzalloc, but it can be
> called from atomic context via the .raw_event callback path. Patch 1
> fixes this by switching to GFP_ATOMIC, and patch 2 converts the buffer
> management to use __free(kfree) cleanup as suggested by Dmitry.
> 
> Changes since v1:
> - Replaced Suggested-by with Reported-by for Sashiko-bot
> - Added patch 2 to use __free(kfree) cleanup facility (Dmitry)
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/wacom), thanks!

[1/2] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
      https://git.kernel.org/hid/hid/c/55f1ad573e34
[2/2] HID: wacom: use cleanup.h for wacom_wac_queue_flush() buffer management
      https://git.kernel.org/hid/hid/c/cb605d48dac9

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


