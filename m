Return-Path: <stable+bounces-224799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBNnMrRAsmnwKQAAu9opvQ
	(envelope-from <stable+bounces-224799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 05:27:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401126D169
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 05:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C72B63072D8E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14F3947B5;
	Thu, 12 Mar 2026 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeicoiGK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C638F63F
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 04:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289647; cv=pass; b=kpllHOQIOywdR+hI4OB0OITFfiVmlm8ocku5fLVdGFT+IxwSiMgMLU/xcBVZGOY4FVL+wd14D9ZH2c3qPkVc/aH62BuvWezEfnSQBRJl7HB5BYFNSJacMM91muy920x+QmpsrqKgHpVjx06B++oJD2MaYM54OYMDVrAYXw++ltY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289647; c=relaxed/simple;
	bh=bgS08NV15zpqEb1qjiuZmr0KhTZ/0NDHrKoU1TsnW1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3eX8Usmz1ZTB9z2yLz5fRD0T7RHVMGid6prLTRt4y+Husm2d3/54Ni/frBcutmtQyhyIkTF2CM59/4TFThH6II2SY/YACtiPp4HuOx1YvSaqCnt5hsanxGDC7u+uk/KI1BxMEBL2sMkfK4oKqkRWRBXsJRZZEYOzgpCdc9J5Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeicoiGK; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b940f962a82so78933966b.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 21:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773289645; cv=none;
        d=google.com; s=arc-20240605;
        b=Fg+byNUw4IAoXgmLIwSNXs3IXfIZlAVryjV5r7X+v2HMETjdXtNhS4kCr0UG+QW9mF
         +Ddu0CEwQFd9nftGFGsdX67bN4KX8ckLOoN2bJkRDm7i3U9HyF7nr6cWPZDsPaBwYQRv
         ZAT5YMKwQKjHRikyyrAEVKtFj6QOtJvs04zx89J5GzYYxrXw/L/aKofPCqfoG/pXRg0E
         ZbPGIc0ulN274lF3N+XC1oAX7JgemIWq9SfaSjFv/QseTSN0hKHWiG6jJ7cvMhmnpZiV
         Ab2j8+tLGaX61Hs5OLZ9f3zAj3Zo0d7y+CFmbyFtM+1RVyEkPKhO5nwLIGH0JQNKxhWP
         h/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgS08NV15zpqEb1qjiuZmr0KhTZ/0NDHrKoU1TsnW1A=;
        fh=lBaVGO34L0cgLc3GAP/sOt73FSFdNKkGx47E0kJnXqo=;
        b=Ba7FZ3CFNfSd95qyVUcIISC2Vy0ugQZCgKzIJDgcWRXEvGqk3rVPikPhNrjLlEpaf4
         fcHnYtn0OcEHAFqkRHZWp/PFtbxNLzlexKEl/bYLfRToiycHbrMley/uTndynky5Gn3M
         jFjc/vSG0W62pt59RBsS6Mu9elH3jzmkoGBqtd6yUd5FBGTqaeLLDd464MbYjG4fCkEk
         AbD05JVdqHnqszsb0zsA2TmRZvTZ4jK4+kXL/gju6JzemuZWy9KqUx2g3Y888zxb04zy
         gOn5dCZmQUZssgO6IbKi7KfLCUp99YKwR0xA/6VU2I+XZr6X7zpsJz4iR8fLYD8u6rxi
         5kIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773289645; x=1773894445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgS08NV15zpqEb1qjiuZmr0KhTZ/0NDHrKoU1TsnW1A=;
        b=KeicoiGKpEZdRfNJcAbq8cbUWTId8t2ZmUqH2AL4y6UEvfmQhi9cGwb2DeTSbkqu77
         O6p2qO113NhGpwaIAzJ5RBXj98blMpOcn358OViR1Lo7ExojLHTbWQGfoWXHFFouBlC4
         8vyJGRTOM1aRN3nlMMHe7lmQicgldvysJVxbW593PhfNvcnUbOLGjORZp2D7YBPLbzIu
         hE4snT8UEbAD6uMtgfwkwwu5E8bBkRNUsIfC5VUR82hgoCipddhLsil/EbS3kU2Z/25S
         OZ/yDf/1GZPp+5WHygIEK8dR3kQiMXjMwQYUDbTpq4S2KYdOoND/TS+CXkyEIO5aidlN
         mGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773289645; x=1773894445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgS08NV15zpqEb1qjiuZmr0KhTZ/0NDHrKoU1TsnW1A=;
        b=IYYgXTDSdWAyD6fDsxBpFHKb6MZWHE6Xvil9Kdaa8+rowV8tJai/DvUGAqycNT/NGw
         MKaxjdRSLDikEGenj+9q6aeXVlEnx5d+OjLVY2cAApG/YtGGYhwxrMAVAHm7n/R1xCyz
         QQJa8gYSZIo2dYDxrIuvUFsL1IDJ2M3TKEBlhmcvcau3qYvwhc/7wxxwADDdPBqVL9aq
         4OfDLWIIDLwfTU/0usIhdX+WKV6gfLynMEm2CbUyDtVZ2jL2NnbO4FLfNKxPKXCAxYEj
         O6TPG4ENPBv6iBbUvFccOLNzy8aHnG6SHX9+xvY5tTfav2vgBZN08SwwR4EF4A/ld0pz
         9R0A==
X-Forwarded-Encrypted: i=1; AJvYcCV9BdWJeiaxB+UaVyLDn1xKWOFwaXFFQbS6v4+PUS/xBtyoDI3rvoZoQxwYSw4dUDy0R6FS/Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkwGuqoKbgOOIEzj6Nxuotxjj12ywGy/S+sQXkdqaiwiyTvZ9
	leKx6C1KP4+0dEtQnfuyIewul7UGTmq0fiyymSJEmKCKjMaqGvymkBVS9HFZIEixc5iGY9e5Mpm
	FEyYxxA9hK6B8yq7+J+CISZteg+EPHes=
X-Gm-Gg: ATEYQzxAr6BIOwyuc3GbllJoeMT1+yz0YeQLVuEM+wYkA8LdPHMoX4Sh2o9n9i2+bgo
	ivTPbUKFjI+1LS19hxJiq8MjHhqjOrPEyDJdDm6lN9rvFD87bjBss4fzcl4DrPtc1OhRjpr3qI5
	1fLw+aeogDX8AVz8h4q+0EeE7nnzDwTzYaK/pZyh2V6Rfzeaxwm2gcvrUDTDg8c9UpSDGQ8v7q0
	3UJ2wPgYlrbnahoLQOD79LkCler690IB3EBUS+YuCuhwxbOUJN+rGy4R17rD7vnCcYyAopSK+mq
	ieU75N4Z1f6QD2VsEyUawDkYWJKE4b9w3AkATwhE0abakJSJJcuq3oA=
X-Received: by 2002:a17:907:9701:b0:b96:d802:8b4b with SMTP id
 a640c23a62f3a-b972e1d6d97mr257929766b.24.1773289644646; Wed, 11 Mar 2026
 21:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312001443.3011961-1-gality369@gmail.com> <17c102a6-bbd1-4937-b5cc-5f6912551180@suse.com>
 <8533b404-3377-416e-81d9-2bdb00baaae2@suse.com> <CAOmEq9UusAbrMLSMkca+DEPff9hXokAvVn3V4acQ0EvSp67HLQ@mail.gmail.com>
 <a478f7a7-5255-4039-9ace-7d2b410db602@suse.com>
In-Reply-To: <a478f7a7-5255-4039-9ace-7d2b410db602@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Thu, 12 Mar 2026 12:27:13 +0800
X-Gm-Features: AaiRm52CLpJm6-aGNQAqlGhZJys1CvKKOMghfPAzniNQ3h5ztDOzV_-MJpZB5j0
Message-ID: <CAOmEq9Xj1+S1oDXaNEP3rWyG9DOd4LWm7sd3P5Ub86Fdx6Tgog@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: reject root items with drop_progress and zero drop_level
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224799-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,suse.com:email,checkpatch.pl:url]
X-Rspamd-Queue-Id: 3401126D169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:16=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
> > My understanding had been that patches should generally be sent only
> > after passing
> > checkpatch.pl cleanly,
>
> No, that is only a script which has its limits.
> Checkpatch is good for its code style checks, but not always correct on
> other suggestions.
>
> Sometimes even its code style checks may conflict with the rules inside
> each subsystem.

Thanks for the clarification.

Understood, that makes sense. I had been treating checkpatch.pl
warnings too strictly. I'll follow the documented guidelines and
subsystem expectations instead.

Thanks again,
ZhengYuan Huang

