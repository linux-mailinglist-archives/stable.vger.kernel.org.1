Return-Path: <stable+bounces-222991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPxaNJHZp2kRkQAAu9opvQ
	(envelope-from <stable+bounces-222991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:04:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1871FB5CD
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35C823023322
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A8351C30;
	Wed,  4 Mar 2026 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuyAdGXd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC124207A
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607885; cv=pass; b=eLg2aBpYGlu3F2sFlAh8UQrhg8TN2lyXDBFsie1a0kGKbe3qUj4//l0xlcE8x9w6WFtvyyaCssw6aGKgjfdM0vWgm5IujkLB6Ux+zcLYaDOMRwh7L/o5wbFOTs1XC/OCs76VZIrkda+bVACkoqkTUnkVcnn+KfiWlXKDNPB5ioI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607885; c=relaxed/simple;
	bh=6dEl8w70zIx7RtQmGCGj7N9KErbBGgqHKuP+EANQx9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g46/kcguaOQuwnLpTrQdJ8mfX4/TyDKOj7om12eR570o19cZPm6w0hNHG3nEs2Z7jDa3uqdDjTenV3gWSq5Qg/4Dye5ny14tTDPpHhr19mxkH4FsD2kK97SIBmV+GImeTQEcOFEMLHwYNVfhEpV2j/X46RvMgHn8dSU9uWUoIjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuyAdGXd; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38700168abaso43060341fa.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:04:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772607882; cv=none;
        d=google.com; s=arc-20240605;
        b=NaQ07voKSCoQQLNeTtgp/88x8Hvdthoz9DZFM5+K+8wLRWKZ6n5/vGBdKNkJkJCP6C
         MSOKv4rJfr5/KHU4TlfeyW2qsx6LjoCpu/xAxVp7dvHiZI4cEwHWHC4sfgAMs058kLsp
         h2Lr3T1qoObRu0iPpiKR+MY5LZiKUUh82iBGdIkpuxLNYzNwBENYspJttGUtExZAICXg
         KigbK2TaOc8Zf9302eD9AAEuhUeeAXQ/lcPzrYULKTTjOtnGdzEqtqfg8NQt+qAO9Rlu
         JSJnWucobRd2tG4vxjmjh3lf0H5CHmNh1nYGqEw/aIg9UqtTu9ZFrtbXY9Ydvcc+kzjb
         jsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lhp76GkJEmISlLLUIZ/1Y1LEXHD4rOCe8Qv7+jklxAg=;
        fh=KK/p07gQTuaScqtBmf72Pwq3nrvqyZIkShE3scYrFac=;
        b=e9Lf69pUS1sNJJgB0IFCCK2Twj6bkgbs2QNs8KSWVPl9lqqIy5k86xAwTfPrsPAo/k
         zo1hEIBbK3CPHb7rpSct1eQ6NLj2lzQQroJWIAzKRJDBXaUWhEvE+/g8+T1NlIDpfhAO
         dZEAgLKnkEZNStZ+xh2HgreXs2T//wzpthDdDBeeFZvMAytpgFLNrexgcSXocI0uSm8I
         Um92Xi646Hfupt3J3lqEf/vVU4K79qcPnZu7hV2Tjs6mlM203MqDeBn8SPMkrzHbaQMU
         PnbZtWXIO9thVdW8gdwBaoR38+ZYsAQOmlCwSrme6+cegTgRVKNhmUVXXx3vcbOtm4gs
         qSlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772607882; x=1773212682; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhp76GkJEmISlLLUIZ/1Y1LEXHD4rOCe8Qv7+jklxAg=;
        b=LuyAdGXd2FlwSrFKS0eV+1ytBDp5XH3L80MW+r7+673vNXe03gOGuR/2pblLUzAHgJ
         A5yfcMl/N4XB7rFLUQQ+Xx7b7ytOIy1Whq1u1nmNSKf6DeRzbcp71btggerpotAYNuFr
         HvTSadexZoeP3X/Gge/S3GIbXvf/eenUnfYmrA4tpAtWikB7/lyvHXTlfqgReQqy44No
         pcJc0cxo7smfUN4LS4hdhs+gWoQWqBTd2FT0DG+Dei8/KNc23vzPkTD4KchjpA3kC6YP
         p8bASxxHBBANL+jVtgVLE+j9jjJXDtXPyeZ0qt15byXT2QVhd3UQKaidQKNnO/S5GlX+
         Z74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607882; x=1773212682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhp76GkJEmISlLLUIZ/1Y1LEXHD4rOCe8Qv7+jklxAg=;
        b=XVxNWr6rQbVR4n8C0yECCMzepIA4pICJ9LAtD5t9AkCSqRIlzf22hiu6FJFA2XYLuW
         +zuichoGBd3N16T8f2JvdtUlzGvV5uhuuVyui7ka3Mak/8XY1aHINQ3woDEWnjLTIl71
         g7jBzXrJvrIXCFI1mDnd1pF9ZifBjzTOBeaGkugjRKjctQ4XyusMWl79CIu8qOxXWasa
         U+PJ/JOjBsS/B0xIzRY1YaJAdBWz9xK+9LOBwpHwJrivpMrSgG1DVOvWEm2bXkzlJYr4
         dk4OedTAunZL0lcjrcFV8tTI6xn3u+l1Q9CoVWgbpJstajTRp8V6LTuU9p2tiFzN/RY0
         Cuiw==
X-Gm-Message-State: AOJu0YxRpSxTWwBSGSQyUmVoN0tjBz+NYAwdY1R4B+EwwoK9ESyHeMXv
	yiH/6dshG0yWzusPZnw7TgWp5GbXF9SMGZf6PQE9H7rKMX5uXNrDdzHBXQpAL9b/VYQfT5oidNQ
	F3l6pvZbuu2GYdSalJf/WlKLXITEyEXA=
X-Gm-Gg: ATEYQzzNlXCK7QuUEkl1uS3Ba7MDQ7v2K2tl6Z8ZE4+zRiYgny/QOSvuboqpW9oHjsD
	b9ZNWtsWE1Pbvsp0C/Y2wUY5/eNcbF1Mq15YqGuBLuBKY0KlYWpSDJXO/L5vyMibqCFVR5BpT7P
	VG/Zoedvqh9pO+ilZert55ZeIkk6Xe9cn5+lCZzZJM5fdaBd+MWqrLu12OtUMYQ/nbIoSzJSVwL
	F7xjnXOBy20jy5IqyVXSF54GB0ovQgwLPlfYt+9PeWW6VvftdCUNrHo5NkpgWmY9l2m8h+tcMmQ
	Zpl/NPYKhOqLL96lTcU+gSmjQMV3cxpu5d+7QMjkcVoBelWAgsMUh2I=
X-Received: by 2002:a2e:bc05:0:b0:38a:519:f788 with SMTP id
 38308e7fff4ca-38a2c58db91mr8351931fa.2.1772607881955; Tue, 03 Mar 2026
 23:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217200006.470920131@linuxfoundation.org> <20260217200007.474729104@linuxfoundation.org>
In-Reply-To: <20260217200007.474729104@linuxfoundation.org>
From: Evans Jahja <evansjahja13@gmail.com>
Date: Wed, 4 Mar 2026 16:03:53 +0900
X-Gm-Features: AaiRm53Vja5JYzpG6D8Y2tyXvfolXw8N_dbbJiJeoIODtNRKq8EUaFhzuL0pkbo
Message-ID: <CAAq5pW_ETivN5trn1CN4XPbHf=uya3TmjTmvwmaaMZVnjqf=8Q@mail.gmail.com>
Subject: Re: [PATCH 6.18 26/43] arm64: dts: mediatek: mt8183: Add missing
 endpoint IDs to display graph
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Chen-Yu Tsai <wenst@chromium.org>, =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F1871FB5CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222991-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evansjahja13@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

> 6.18-stable review patch.  If anyone has any objections, please let me know.

I reported this but unfortunately life gets in the way and I am unable
to test, please go ahead with the release. Thanks for the hard work!

