Return-Path: <stable+bounces-223031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJEqJioVqGnUngAAu9opvQ
	(envelope-from <stable+bounces-223031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:19:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1831FEDC9
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C87A3025F5B
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F737186E;
	Wed,  4 Mar 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbchpt1p"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92951375F96
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623137; cv=pass; b=Wsy774b34eW09v3Pk1qLNYxoe6ACfDWCuL7QXHv+C898lyfjR1FiLEDlqiojboKCIguvKVvSyMKbZ5GzXmy7DUi/5ZZ8TFc6J28qS/Pq0d8/HSm77I+9H7I0uAavK1vd9p6gjEEmACRSRmc0m/SjtPJGtcKPAxMC2Y3+C36IJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623137; c=relaxed/simple;
	bh=k8xntpSn4kLN9LGpsUOGFCVWlyTenObtEwlAbjkHhNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT5b9uNoaa3Ug2vhRaAmfbkx4hWC/WqpaA2RAFsgGGbgUR0TjnEZMZrfg3P9R9Fl35zfip6YXLhdaEcealDEGTZdmbWYPQkHCKE7cP3eq4gqMLVp2t7Iyiv6bVzvhembIF6mMQuWggFNel8AKYqvZ+BIFpGhrDf/9ac/2jczFHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbchpt1p; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870dec27f4so55487351fa.1
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 03:18:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623135; cv=none;
        d=google.com; s=arc-20240605;
        b=M8HFOQpk/ca2vGU7w24CQ3yezt6DlaHbHN60d2Oqv22/xutQ/f6exR4KBWFl3tTVWU
         ZZgEanAQ4SCtLnP1iAs31BLWN/4yYachrbDD1kFjS0GjnbBhnqBS+vrO63lh20nWcX7e
         8cueHl2xfOrrbxVmxbcWvYanUhU+mS4l69x5JajsGiH32prl5Eskkkyj8PTaDnykRwU8
         zbNqTzarljHXeF2S+24zJUXn2LoupnOjZ0nqmLGe/cCjf6JP5fuAQK9wo7UCb4+60HhB
         MxTk5osckC+aNlIVUUmEi6oc+/IGtUBB9rysyJWkQXo7aIHvLB63HTn4QwMhKviegWNo
         eOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k8xntpSn4kLN9LGpsUOGFCVWlyTenObtEwlAbjkHhNc=;
        fh=vkVJElrC6y+YgdguXclGemK0WUwENM1g7csap6g6wc4=;
        b=lqHYR1ynlqJa6vINNO+pusxCQLY5jDlOhPYNv2i/B77eBazlVVCzNeu+9sD8ReLc6V
         I5rKUiKc10SQDxEQ9rRHwIrvlyBdncgLIfwPnvXwqajl053rCh76nqvuZ1oB3ITYP3C6
         eOuOo6R5BtHJe3LLVWvrVIElL4Kb29SrFvRgQN/zVcQaBASnTVvVnvUxbvxB3X1h7Y1p
         bACtIPwd3uphFx+0CIMnaYuYIKhTTqgXf4K2yA7IT7DeyMYfzmsh0MphtlKAPZGulWhY
         z2j7Wp2rBAd3b5L6xUEGfaAYI/EnhG91rsQ/qmo8BtAf1vFe9BKDJTIzFpsghLgsUfml
         xkfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772623135; x=1773227935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8xntpSn4kLN9LGpsUOGFCVWlyTenObtEwlAbjkHhNc=;
        b=Sbchpt1pl4qwgHDInOHJzXeSlpxrS+H1Msbr2Upjx03lnRyN2gfVDl6JDFJNMEiUOS
         ywskKclMsagXf2IhHKuVUS9tIvHOn69Y0EFiM87tnnLFXDp2ke5NEqfZHtkzGJBl5P7Q
         yihGEJoij/q4uQiQsTBSq+fvLsxcEPbAg9Hru0GkNHA7QArcWWfxg+PA0eacQLOrNG0R
         RxttAB8xbWLauffMTW4giS9beEOvWUVAzFSWHtDf8qe68Zi5q2Zpt/HRGJge2unt9Dde
         itjmd1+k8vBdt7ceAvjgTDvhco57vZaU5jsVKTopMwHG5YVW2Qpzi2asc2gtLD5b4eG7
         qJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623135; x=1773227935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k8xntpSn4kLN9LGpsUOGFCVWlyTenObtEwlAbjkHhNc=;
        b=d5lGAKLup59a9sZr1Lbfk7lOpKCPdhFrxcl7hSx3+lEv9S3ePxPsqxGew2ft1W2zn8
         R51hLyB7kcS2MnaOkRXC2WjZhq4ccf/JboqLDfD++Ktq4KdbpL3cj3vzHgLNGFAQgwol
         /kE1t0iZsai6oH2ljA6jK9YfkI3jGkxMoU6IiI9VG6GSLftUJRzzf7KUbSTZJAPVspao
         tlvFHLvo2IBp0lOsUZpYfcoyK2Wmxy4NuGyhcEJUXBEI17Y6DITkMd+/QdvbcqEJMSDa
         BvfNfPLlr4WPdE9wvcloPmpyhVgwvMYEp4kcCCgZoh/q40QQhDoK7cHyXrFUDtDnT9ys
         HPIw==
X-Gm-Message-State: AOJu0Yx9PcPnFSQO08/GJ4u29nG0pM60nDfDHRmFAJWAnjCWeYTmC6Jk
	XW5gbSDtGrn0N8dRl8yieL/+IuVdmddH6XL5eez1tWshyzZXVIyTa8htKUFOJWdjep3wCdbjs83
	MFSaErjCD+jbTA/MGcqlXDCPwE4VaZIU=
X-Gm-Gg: ATEYQzxOBv6/blFYr23ZP72IemptxVDdZEhzLBM8HWCAsVbBSJaA3VWkUXrjIBHu40U
	VTQ51VNVrkFa60gW9i/tA4jiOzxT54saOkQfkhn0HO/sLHAUcuByWFseqBX+agUISCh+iAUrGiK
	q4UNRRlCT+kIdHRlHGlMqUSOt1a1g9oDiNcr6Ff80wuQI7Eqd1laM6WkQ9Yvye/Nkr0FJecqEI8
	Vb8mSEJ101xsbp3noItZIjKtY6WCT8TzwvtNKLImxdzcbl4aLP0ajkeOfOlkokleAa2buGTnrS4
	GOC0z1Oz0RclC4pvSLt2FkL+FcxeLpH/YYQ5RhzE5qEAR4E3xki/jtjiYa9dgun3ynvQ9A+X
X-Received: by 2002:a2e:9699:0:b0:389:e2e8:4f4c with SMTP id
 38308e7fff4ca-38a1c42fd11mr29290901fa.21.1772623134489; Wed, 04 Mar 2026
 03:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303132143.766078-1-festevam@gmail.com> <20260303132143.766078-2-festevam@gmail.com>
 <2026030422-snore-parsley-2501@gregkh>
In-Reply-To: <2026030422-snore-parsley-2501@gregkh>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Mar 2026 08:18:42 -0300
X-Gm-Features: AaiRm52Zvt2iFWuVjmnPrIN4MBFnJMLdY5blf3E7Xmb8ZskefAx76djlwC0TdMA
Message-ID: <CAOMZO5DioXemJEmX2Zu+vrwpOii_hQCoz-Z8XQYvPkcuzQXx9w@mail.gmail.com>
Subject: Re: [PATCH stable] ASoC: fsl_xcvr: provide regmap names
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, broonie@kernel.org, 
	alexander.stein@ew.tq-group.com, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0F1831FEDC9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223031-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Greg,

On Wed, Mar 4, 2026 at 6:08=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:

> What kernel tree(s) is this for?

6.18 stable, please.

Thanks

