Return-Path: <stable+bounces-230327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJQpIc/Qw2lBuQQAu9opvQ
	(envelope-from <stable+bounces-230327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:10:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D7324895
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE3243104AC8
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681D3D1CC5;
	Wed, 25 Mar 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQYTgU3o"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBC3D16F8
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774440229; cv=pass; b=su/5VYeNT84C18i2c9lTWFf96G53u+KNal5V+cfGPUXSZmv9+AEyp8AK6wcLq9UCtFoD+0PaTmri4yQp1iXCdjrsJ1sWhMJS9bnoYR411zHpEtrWDjUmE6rhzTtEOo1v89BOkuLR7WBDIJjOV40P7iWHYYUAanjxLIH5aZFKJvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774440229; c=relaxed/simple;
	bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5TgjClvi/pvELrZKkfvwc20lk0GtgD4LSRth2bKV/vdSoCjRiOyL3TI8WjZ+xtXzCi0S1xZa5HJcBs2tkfIpV+2J5kAs8JMzcqeFUbNMIbmlWmtozKroXUuPd3qhl6S0S1P4JxNI17b4rUOCMDOjBeQ2DJ2tCNG2HMNBvDuuXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQYTgU3o; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66a9a2187a5so506531a12.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 05:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774440226; cv=none;
        d=google.com; s=arc-20240605;
        b=NnpvSNpvzUreuD7nRp5HxoTu78WLXQPCyGDiIi8vh2kTDk+4BET+meo3Tb5KOWm2Kr
         1tMB1eCrtSU0OC6X+skuINmizAcytE55obrNDBdwXv9ltQr+AZcN3nkdFEyr4+EXWSOU
         DnG0WS7fRGeb7SPQyg777NkgirqqqBezw4/thT8+tTRvDhDj84HwcSPgJTNSgeiWD3RK
         Ko1DM5Zrf4prtqtbxNQ/gsEMvTL0we9GJuL0zFI0Gw7pB4KOYQPUtCzKLnInL1JyEHPi
         azX3x1noeBUzS7SgzgaK6rOtlBK3cBDa8WAhhdD2l+avkVi+6OXsOLxnjDNNwosajR/a
         guog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        fh=wijcXuyzZoD+adLIzREYrldapKEV3CIVSTVQLC+58QY=;
        b=W+4MCHlUPUP4hic311OEtkYrJrcJM3kuvtfLeOCLeuwUvPVN/GLq1+qEhPNovA44nk
         NsD//TU/oqmwY5odHSKwJlLlthQiK6V9gvAb8zkWGl1yCsDKqi18BKJruLxFDgbgI239
         HqrtQD/2tzK5/bEIfejBndPH/OM2TQAOGPpvaxGBu/mt2QhydN5QhZ4x5OHJOeLn0xgm
         DkjwupDF+0nsjXlj0mCwFgJI4fFTjXtlGLdcXqbSiwMTTlUw314DMDIR3bS8AZLOyCC6
         +APzb4zJlc8hltr8yGbAPopdsY48lJVQB4A19MHgfCX72MQfcoJfLRZFUdFrsDkFw2v+
         YQOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774440226; x=1775045026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        b=QQYTgU3oqQkkuA3YhoETSzobfKrhfbQutworh0GWHJzNSUEQp4IIw8hk1RnWf/sWY/
         jFpSW502ikRTJW0UXmYbQtp3hH08zM+qsk0pLGfDPnxUY+c8Xo+6DsssuGnJZXlN6nQL
         XEeg+fXMsug+TQx6DcAbHqL9VNYMpfW+7qT4oj+Er60ErVHnJ0wb5hvsMwv24cewZGP7
         oPLLJTAZ3JscWgATaEzi/hBTuZdYTdFH9cOYqT8D/f1DvQZiGKNzTxs3Mh7QTNPsRbQk
         KxDQPF9J88sleBn0kW34Z6DYf4LH3pZMtrgAkZW5N7FWsJh9afPjZhnT0oWLonhph9th
         IESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774440226; x=1775045026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vb7uvMgj+8pqSx85DvCgOQ/cEcgsqLMGegmZ1K2OngY=;
        b=B8IQL0ZtmU/+NjeOIl1z9DZb4giPe3OssgIWutUWM5JeJxEWfyvoVCm7MQzZzFsN4f
         3aYrq5B2tT9sezVmWGD+awLRmcz3pgaOSSlacsCYYLKL8wGyQOlMIzxQmO+pdLJvXaU3
         CeTiZbHJF+HTl+26QSYJ0Fh0uvo7z3Rd5WHt0W6jC4MjTG0fnx4R5ZxQ/Xzd5MzBpaLs
         KoYBgNYXH6iJx/GzpneZ3/mZtV89cCO+Tu/ja2tlDXeqdd1q3YVNwQR5tyftgHHUp7Jj
         OOTOAM51eX7Rxj0DygmbbhGd38zrbx5VDsp1SWOvOTqddemtsXfZSHuRz6ich4wGi0e+
         cVhA==
X-Forwarded-Encrypted: i=1; AJvYcCVuoXPjyjhMlAdC4TeZ/EJfic7whhVGPh+sODPs+zWSI7qAJ4DVCm0FMfJm219BMoKsoo1Wb0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QrrwrgiPpvx5VEKjS2Ym7xrrDZu8YTHQveyGm0v8H49hz7OA
	0eMxKqW66pSLX8ybczDXsxun63PPqe1MEvOcOipYsQnXEWH86Kzjr0gnufKh6mLcywQnNeZdPwZ
	wR9I8kTBB4maiPwT4d+2KEvsEvZf0o0s=
X-Gm-Gg: ATEYQzyuobFG3VBeB0oY/Q8dbAO5AIlit/thRqTITNZuPP4kIgx+MJnvUGpVUP321sF
	5GiTwbCr2rbJTNAxi+IuazthPXFzQgIG5C6y0C5UeudcdrzJl/onXL6TtMOFqEvJgeC09bZPP1D
	mkAzaymqXe8/qf4SKHt2sBXq3srSbNNyYUYiHSdibzzP+bCuCMpgKHYLTzkDrYegs/TKQp//x13
	NX3ru7q0TqcP4G9oHAa2/WzkCxz1lus9X8IAJqxUdxjR0EQAgps1OsteUE1MCrfeqYv5gA+ihGl
	b7P8kKrARwA7GxNZ3Bj9DsBMnNfsrwUH0C0x89Cm+A==
X-Received: by 2002:a17:907:980e:b0:b8e:796a:fd5c with SMTP id
 a640c23a62f3a-b9a5425bcafmr230697766b.27.1774440226200; Wed, 25 Mar 2026
 05:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324145750.90719-1-amir73il@gmail.com> <acN457svKhT5TcKI@infradead.org>
In-Reply-To: <acN457svKhT5TcKI@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 25 Mar 2026 13:03:34 +0100
X-Gm-Features: AQROBzAGy3XNT_kv4MdESc7yjI0imOrkuxyj3QWBiKFezafRk0eZnnUgjwE_k90
Message-ID: <CAOQ4uxh5NFvXGop6ne-zfRbH5p6BPT2kCt7dUkP__-TtpeJjJQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make fsync after metadata copy-up opt-in mount option
To: Christoph Hellwig <hch@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, Fei Lv <feilv@asrmicro.com>, 
	Chenglong Tang <chenglongtang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-230327-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email,asrmicro.com:email]
X-Rspamd-Queue-Id: EF0D7324895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 6:55=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 03:57:50PM +0100, Amir Goldstein wrote:
> > From: Fei Lv <feilv@asrmicro.com>
> >
> > Commit 7d6899fb69d25 ("ovl: fsync after metadata copy-up") was done to
> > fix durability of overlayfs copy up on an upper filesystem which does
> > not enforce ordering on storing of metadata changes (e.g. ubifs).
>
> I'm trying to understand this previous commit more than this one,
> but what 'enforce ordering on storing of metadata changes' does
> overlayfs encode right now?

On copy up or a directory:
1. create a directory in tmpdir
2. copy attributes and xattr from lower directory to this staged
directory copy up
3. move it into place in overlayfs upperdir

Until commit 7d6899fb69d25, there was no fsync before step 2 to 3.
Only when copying a regular file there was fsync after data copy up.

This of course provides no guarantee over the state of the copied up dir
after crash, whether the directory is observed in upperdir with or without
the attributes, but in reality this is how it is since 2014 and for many lo=
cal
filesystems (e.g. xfs), there is little risk in this practice.

It should be noted that overlayfs is quite picky about which filesystems
are allowed as upper filesystems and specifically network filesystems
are not allowed.

> There is no real ordering requirements
> anywhere in the Linux file system API, so it does sounds like ovl
> is making some assumptions by default?

Correct. I would say "making assumptions" I would just say that
overlayfs has never taken this aspect into account.

> Are those documented somewhere?

I guess not, but now that this commit introduces, fsync=3Dordered,strict
and a documentation section about them, it is a good opportunity
to expand on this point. I will add that.

Thanks for pointing this out.

Amir.

