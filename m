Return-Path: <stable+bounces-242207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ/bFqHC82mw6gEAu9opvQ
	(envelope-from <stable+bounces-242207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:59:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014EA4A7F93
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B96663023529
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6F2874E3;
	Thu, 30 Apr 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRi5Ngjq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87B35A3B1
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582733; cv=pass; b=TXoHS/RKqjmP2K4KZkgHE6iv1lsGIpjRJ1Vodk2jiIUIBT8uRRRbMpQEwhudEoeEhh97toI1gx134lEUanEWNu2wPtupn7OFb15jfpmXG5WumGquBX2IhSrUWHicf6yAxPGROIX75r5wvbU+Qat4Tkcn7MyFDraAY7hhgjEah2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582733; c=relaxed/simple;
	bh=DZm88FmcH8LX12G8Lj00Yhlmj5kB1D8w1Kmsk4vwxIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHkDD5uCIjmZHpIUx2Lw40lafxdrTI/t+5w27AFZwQj1y6S/AnihefU3aYAkSt2l8P+3jbMJzoSwYozvT7zqkDftmZMRwZOTp9FoM/43FvIXiR9GhyJYhKd1D3vIluB0dfBBFGEz1KBccjO91EUE4DmBt5uC7xmRjONJcOqfCfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRi5Ngjq; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651c7ddf514so1368950d50.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777582731; cv=none;
        d=google.com; s=arc-20240605;
        b=QUce2cdZj+UEO1OIGhdtNlYZvaw91+VuQEaGWkB7+frSpIz2k/qbKDeEQjCruJM5u4
         o8JRBT9V7L2lPhPZLHkadQOpZ2nqSBgsv+AGooE2092fJn1S11c6bqWzDvY59iY08GSQ
         3l0JqigZW0PC0rmiM56row7Xuj1CsXjqfJrgr8O9T49YTxxXlTYQTUCuzFOHZS5n9CQ6
         fJlYeHa9RAu3UHd8axwcVzHps3NdbncNDl594wLxkamV+HNEEVREuExioHYjDC30q6n7
         5T6edMG8wabNFHklck6VFUuB/FhcGzWeegAyGh6ruXuH3WrFnlC8ggmwY3wAZNJ47Q/O
         ctow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        fh=JopJXpYN5N1hJ7wU3TwR/zXapAOVUv1wLhnr7UvZhgg=;
        b=NXZQCU5wFNLWDRuMTgS2hW45UBmTo6AV7WKMbeFWwX1Quc36zxfZUi/5bfonctrdDK
         oMB8T4E6hYyrf9ToQQ9xEM1GDOJvFs9kf8OVmmGaBzNs6jtnsNQ2icAR9O5iLShCQez4
         aLQyTxRC5HzB2UlWEleEQT75TGRb8sZmoinROMc4mEFpheZwdc5RtrhzYM14WtD1SRTG
         6o7gqfy7twpGdWg54XsyUZroYfmDOBcuPrPz4DQGlBOUQwJrB3aaH/NfqmEw4Y/nQOUf
         NYz/nWGBb4Y74BTStkDWmKLsbSysdrufBB3k+nnY3O0D7n5eEyczBGRV3ryypjZIETeT
         brXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582731; x=1778187531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        b=HRi5Ngjqb56ijwc2YXXzEZlot5RNqjlczTMFHwWzl7s67CTkXm2IGAySetX/i/lCST
         z8HjGsPM7yCW36u3X49H0yf+Nf4hW5Ph/6YiwUb3ke5mTk/2IMaxS3DaXlxJE3tM/TM1
         M1kR/n9XMCzKEhs2CW0cAYcOmGuDaXRI2TE/KCpBH4+Q/0i8VAIoQxjos3dHLzqwNxUj
         BlE2IoTloLNGlwBhwNhcByC2hTuX8ub6jkdcid1cQDVnO0hPbRlkETeqrZ8PnNXEgkhv
         r+sZh2DnXS6UEf5lnNbcEQR8ZOB+h+R6IxYT4cewRLZW7uPPPSmWDQtr+M81GEDObUe+
         mXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582731; x=1778187531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        b=eSPcVcSPZ9phyTic2xczdGTrEW9UEW7PiJrJCQTzLuuwTGjJXQg1MPNhUHjKyWkucv
         blBoyoPuttAKyLZ27Er45L+ST/xN7H4PgOwfapgJKF3TVyZtbrYvfx+QBBupKqHk+aMb
         oH6A4v4avQp6Q8jPrBOlO7Fq5YS793vSP574lq4MAj50iWFKQUkZ13/Oekrjo+iRr8kG
         qix3DzU+DG5R6gxBd3cWoHe4fQv17aqAqW0032eMuCh5vGqQJlq51dIdY/WxSOhOdUY0
         Zh57+2N28NQucT057gEKyragn/ZWNXp9UwOaqMdhzNEvEIActwi0Oz/C/i6LsIVtJq1l
         yU5g==
X-Forwarded-Encrypted: i=1; AFNElJ9QGHHgn5p8/RHPevPsVEyJ3iN8tpFCXusBJniU2IB9cSx9/gy22RBeiBwvBBbO4bk54ZCzRyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzShX5yNk9MxbWERwFWtJZMA/eEbwi4LHZB6R9NHM4qMQBsljA1
	6jxgu9EnBB20/YzbZlbTigSMAsIT4d8kXQCnLFanntZ0spXZRQdR5puaHivGVnm9TlN3DZQ5Xc5
	p/EdFXi9/0kligaN6tHAtl7hFoh/QWx548zahhnM8
X-Gm-Gg: AeBDietA750ncjxfQBwCHzoS8wmMUA1RiAwg5W3IgJphKG8wfw0NRqo2Ls+su3qMbnz
	m/F+fx3yAjxb8hB2NaMS5OkNB7ydwlSiPfZOO/qY2zZFek+hdF5QPIbmJl9GB7NzEAM/T+YVuCz
	tdPk2OV/ROKArTfcwy9I8UCAGHriOXODSQUFSri8Plyud/XBOl90FJEXEVO5g6My+A2fcn+bJgd
	VaKMGN64JJBWxNl3GgNnoeyr4+b8GJHOppQvMSjK0AHM7TW0BxOnXxILWS/fkh5jkUNmgK7r0L8
	pDCDH3kQr2O7Wn5zBoZn4HzfRzDIK44swLa4gZ10kYJzGWy98ueDGfAd2PU=
X-Received: by 2002:a53:ac83:0:b0:65c:2ac8:ec3a with SMTP id
 956f58d0204a3-65c2ac8ed74mr1612608d50.21.1777582730691; Thu, 30 Apr 2026
 13:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421051641.370436-1-boolli@google.com> <20260423163307.989421-3-horms@kernel.org>
 <25163a38-53b5-445c-936c-0cba94cb731f@intel.com>
In-Reply-To: <25163a38-53b5-445c-936c-0cba94cb731f@intel.com>
From: Li Li <boolli@google.com>
Date: Thu, 30 Apr 2026 13:58:38 -0700
X-Gm-Features: AVHnY4I8U8-NSsj-bnIoiUgXgoUy_jiPXyvaEaAv_OuN_FcN8_8wmmTGL0lyL7M
Message-ID: <CAODvEq4R_7SXfo5QJ0z=fM5npz1ZFFcCQTTKkdoLKtXyoDnjRA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: do not perform flow
 ops when netdev is detached
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, decot@google.com, anjali.singhai@intel.com, 
	sridhar.samudrala@intel.com, brianvv@google.com, emil.s.tantilov@intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 014EA4A7F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242207-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

On Thu, Apr 23, 2026 at 11:40=E2=80=AFAM Jacob Keller <jacob.e.keller@intel=
.com> wrote:
>
> On 4/23/2026 9:33 AM, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > idpf: do not perform flow ops when netdev is detached
> >
> > This commit adds checks to prevent crashes when out-of-tree modules byp=
ass
> > ethtool core locks and call flow operations on detached netdevs during =
a
> > hardware reset. It introduces netdev and netif_device_present checks in
> > idpf_get_rxnfc and idpf_set_rxnfc.
> >
> >> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> >> handling a reset") prevents ethtool -N/-n operations to operate on
> >> detached netdevs, we found that out-of-tree workflows like OpenOnload
> >> can bypass ethtool core locks and call idpf_set_rxnfc directly during
> >> an idpf HW reset.
> >
> > Is it acceptable to add defensive checks upstream solely to accommodate
> > out-of-tree modules that bypass core kernel locking?
> >
> > The core ethtool infrastructure manages locks like rtnl_lock for in-tre=
e
> > callers to guarantee safety. Modifying the upstream driver to paper ove=
r
> > locking violations in out-of-tree modules might contradict upstream pol=
icies.
> >
> > Simon says: If this is to address OOT module behaviour then I am concer=
ned.
> >             And I would suggest that the correct approach is to fix
> >           the OOT kernel module.
> >
>
> The commit message says: "OpenOnload can bypass ethtool core locks and
> call idpf_set_rxnfc directly". But if it somehow calls
> idpf_set_rxnfc_directly without holding the appropriate locks, then no
> amount of changes to the idpf driver will fix that issue. It is simply
> unsafe for that to be occurring, and this feels like it just patches one
> specific problem without addressing the root cause that something is
> calling the drivers ethtool function without correctly holding the
> expected locks.
>
>
> @Li Li, could you please explain more details about the workflow that
> triggers these behaviors? If it can't be reproduced with in-tree modules
> then I don't think we can accept this fix.

Yes, OpenOnload calls idpf_set_rxnfc directly without checking if the
netdev is detached first. I've discussed this with the team
internally, and we decided to fix OpenOnload directly, rather than
adding the check in idpf.

Please feel free to drop this patch, thank you!

