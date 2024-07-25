Return-Path: <stable+bounces-61764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24E793C6BA
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB028107A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F219B3E4;
	Thu, 25 Jul 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXuy6oSY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0D19AD81
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721922377; cv=none; b=uslfEUmEDYw/ySNIZje6qamj8gocgC0XuALq2gVmYYyGC7Tj5V86g4xDkuIyKX2P0E9mcp7pMhVMhrK8HZ0xmmjXy6UH/VHb+hPVkVNYJ5ZRwC85mGb8fTH034kE+pCBu5dkT6d3yeaEUaQeXUAFaZ332Q9Y6v8oTRHXPYzqbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721922377; c=relaxed/simple;
	bh=D36HI3O21wtOwQWIMqdPjztnICuCP4ggoiyI4oeov3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcDbl94YSYSx329JZCVdoY2Wil3HrfGXUfP6NoWCACTZlvd0WAZNJXC4f086Wu38ZO/iW0/Ko/sWZ18MxNT6M/AmHTUagfaFh+Zwx8EsiTN34iHx2as66lijSLLNY6QH8FalY6URds6U891lAXhlQ4sbMC7Ra3PAHVL4XXPd4xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXuy6oSY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so1490359a12.0
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721922374; x=1722527174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D36HI3O21wtOwQWIMqdPjztnICuCP4ggoiyI4oeov3k=;
        b=eXuy6oSYSx+M3iE7t2DURlfLSAocegTFAuGqNAXBcklbWXtAfGnxqT9fxY+lEEGWPD
         BxAB99N6B1JKgbC2l2Fl2VPXNrAGbwxM2TN9hVa+PtROF/65Tx3DP5xi60Ff2+FIypUZ
         DQaBWueffvxmJzb5Wh+bcQ7xVjfYTnTtIpcfHehABShRLa6UDvGZOlrrpgjvjdCNE5z1
         4lcc299WDixNIQlw8sqxBPdFfI9pBn6y/sVBqZb3PkHSpggJ+P1wKutegnkHGSLrAHgK
         l8XDueRinS36jG20YrEY9VexduoSmo/mUqaLQZ7yYG7N/Atc3Z42FNG9qvGMK3fRrAj1
         M+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721922374; x=1722527174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D36HI3O21wtOwQWIMqdPjztnICuCP4ggoiyI4oeov3k=;
        b=k4GuYI2ljoePHW6fMxAlxiWTrR74QmwGpAqH05IsFKreyVSWxJj/qzKbZJXBFZLdTJ
         DKWD/44hld/Kpya5bMzjyFiOdkQqRrflzdvmbpMo3v5N6I+t+SHk2hSboPAkNJi/F5ys
         DrUR+IIUTFEN0ANAwV5YSa3C1e1wHP8D9L1y/XAJbT3LjAfzslLUNcEpD/y334uoofJC
         koBV7dUJ6izwhz5orNb+GF4vCWYn9xIcrEHIcFOxKyGEBWI4lzCOGsBhtxhLsRR9O/mx
         wXxy02RNP0WHHlYkDiHR5DRfiVMUGV2n2yFM3JxYFobRORM4drhN9yj6aEkDj4m/stwT
         tDTQ==
X-Gm-Message-State: AOJu0YxiZnKsl5gkk9vBFQKcQusjHspcFXJzhQTLZXzvcIok0uToKdq0
	Rii5hA1crdyZj+oS1lJdSTOuLlYgJ050k+m4t0yEgT4h8Q+Rde95Hg0cC6UuG3EyqAhVSi6qstQ
	QO7behL7egYLYVuXteCYxM3An1uCbEZNz
X-Google-Smtp-Source: AGHT+IG+LgLdvCyVBbSIpIe5ThMyhIQ20Tx1i9XzyAS1qhVrieoXrVtF/ffhw2IfLVtxCGQYY/xlQPozaekz21AZxSs=
X-Received: by 2002:a50:d65d:0:b0:5a7:464a:abd with SMTP id
 4fb4d7f45d1cf-5ac63c50fc9mr1829238a12.30.1721922374047; Thu, 25 Jul 2024
 08:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725135313.155137-1-sergio.collado@gmail.com> <2024072521-ducky-record-3b13@gregkh>
In-Reply-To: <2024072521-ducky-record-3b13@gregkh>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Thu, 25 Jul 2024 17:45:38 +0200
Message-ID: <CAA76j93yfR7Z=g+uEk4OV6N3FqXS5XUXUw9DOKLbJ-yBP1MHVw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] udf: Convert udf_mkdir() to new directory iteration code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	Jan Kara <jack@suse.cz>, syzbot+600a32676df180ebc4af@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

 Thanks for your feedback. Honestly it was a clean cherry-pick. I'm
not aware I have changed anything ... but I can be mistaken.
 I checked with the original commit, and the changes seem the same to
me, although the changes are not in the same line numbers.
 Is that change in the line numbers what you mean?

Thanks!

On Thu, 25 Jul 2024 at 16:21, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 25, 2024 at 03:53:13PM +0200, Sergio Gonz=C3=A1lez Collado wr=
ote:
> > From: Jan Kara <jack@suse.cz>
> >
> > [ Upstream commit 00bce6f792caccefa73daeaf9bde82d24d50037f ]
> >
> > Convert udf_mkdir() to new directory iteration code.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > (cherry picked from commit 00bce6f792caccefa73daeaf9bde82d24d50037f)
> > Signed-off-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
>
> You changed things in this commit and didn't say what or why you did so
> :(
>

