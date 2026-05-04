Return-Path: <stable+bounces-243863-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJvpCzTA+Gnh0AIAu9opvQ
	(envelope-from <stable+bounces-243863-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:50:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E84C0E0D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39647303E2CA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FBE3DA7ED;
	Mon,  4 May 2026 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b="pMVP8K1P"
X-Original-To: stable@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5533321A2
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909733; cv=none; b=G50lyCTPpLKPpoAOTsxSc3GCV4s48Sev4ecFaTWiDfgOWGdn2+M1O38q69BZGRKsuGnNWEqf0BVgt1z2DUg6PxTupiJlFVn3UAGCQ7uN+lMI3IEFifwjtNJRFt063E49IpKP7iuikKQ9rjZQ50Zt3QkEvs30pXo5viJnL9cn4Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909733; c=relaxed/simple;
	bh=04Y/K5VDRi25LK9LlB/Zbr8srRm7zmupjNgFmjG7L84=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBio5hVMcGVs1ITPgy2lwhhX/uCVUDzccES3wSwCHJmxfcpVw5RIHIcdDEyuaQ1HmBlppvsQRuocNTCFsWbCerI0ZH6TYyA7g0X3nhWmYonmk4ZSAjuKqpk4ixMDGXUNZ3wIqVTqQNWnZK/eMJLJ5IC7ofuNLY3i3JB2olqe9JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai; spf=pass smtp.mailfrom=innora.ai; dkim=pass (2048-bit key) header.d=innora.ai header.i=@innora.ai header.b=pMVP8K1P; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innora.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innora.ai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innora.ai;
	s=protonmail2; t=1777909715; x=1778168915;
	bh=+jHcaP3g5S6HHwy4F6oN4vGmat21NwzUyYuheLKpT4A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pMVP8K1PTjzB5KtLFC3Ebah+FvBWZ7fnyZZrrykWpPz45xggvmdtd/E+g296IU9bD
	 q2QR87XIB89R8P+QOOxa8WChXP1uHKCCeASKDPAEHmqGXhfDMTrPX2OFnvajL0TOAW
	 fKe39p8Gk7dv3kEbsssUPNaMl1f7S1OefzaP491jz2irUE9MLcFFaBd2udcdNZp/RM
	 +faJ/cORLZUfusoPu0hM1MbkLPLfSfVrq6+BN2kTeJYi2ETIZa6iHHmPHm9q05jqUz
	 Vy9JvhGWicD7VU9hxHkSlorbwcoa5huMk9FcPamFub1tslFB92NCuaW2P3QujVXEYC
	 XRze5NPP93k5Q==
Date: Mon, 04 May 2026 15:48:30 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: Feng Ning <feng@innora.ai>
Cc: Feng Ning <feng@innora.ai>, linux-staging@lists.linux.dev, Luka Gejak <luka.gejak@linux.dev>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: fix heap buffer overflow in cfg80211_rtw_add_key()
Message-ID: <20260504154823.52057-1-feng@innora.ai>
In-Reply-To: <2026050417-monkhood-backless-4c3e@gregkh>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh> <20260427111738.33069-1-feng@innora.ai> <2026050417-monkhood-backless-4c3e@gregkh>
Feedback-ID: 140578448:user:proton
X-Pm-Message-ID: 540f3df26f76d6b45f51ef858be4274927d84568
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E9E84C0E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[innora.ai,reject];
	R_DKIM_ALLOW(-0.20)[innora.ai:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243863-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[feng@innora.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[innora.ai:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,innora.ai:dkim,innora.ai:mid]

On Mon, May 04, 2026 at 04:12:44PM +0200, Greg KH wrote:
> What about these review comments:
>         https://sashiko.dev/#/patchset/20260427111738.33069-1-feng@innora=
.ai
>
> Are they incorrect?
>
> And was this tested on real hardware?

Hi Greg,

Thank you for the pointer to the Sashiko review.

Regarding the review comment (Medium): Sashiko suggests returning -EINVAL
when params->seq_len exceeds sizeof(param->u.crypt.seq), rather than
silently truncating with min_t().

The comment raises a valid point.  I chose min_t() for two reasons:

  1. The upstream cfg80211 framework does not enforce an upper bound on
     seq_len before reaching the driver, so a strict -EINVAL could
     break any existing userspace that happens to pass seq_len > 8
     (even if no standard cipher requires more than 6 bytes).

  2. Staging drivers historically favour silent clamping over hard
     rejections for parameters that are out of the ordinary but
     otherwise harmless -- the primary goal was to close the overflow,
     not to police the caller.

That said, I can see the argument for -EINVAL: it makes the contract
explicit and avoids installing a key with a truncated sequence counter
that could produce unexpected crypto behaviour.

I am happy to send v7 with -EINVAL if you prefer that approach.
Alternatively, if min_t() is acceptable as-is, I can add a brief
comment in the code explaining why truncation is intentional.

Please let me know which direction you prefer and I will follow up
promptly.

Regarding hardware testing: I do not currently have a physical
rtl8723bs device.  My verification was based on code review of the
cfg80211 key installation path and static analysis confirming that
ieee_param.crypt.seq is an 8-byte fixed buffer while params->seq_len
is fully userspace-controlled via NL80211_CMD_NEW_KEY.

I understand this is a limitation.  If hardware testing is required
before merge I can source a RTL8723BU/BS USB dongle (approximately
1-2 weeks), or alternatively a community member with the hardware
could confirm the fix.  Please advise on your preference.

Thanks,
Feng Ning


