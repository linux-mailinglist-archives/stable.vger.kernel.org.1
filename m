Return-Path: <stable+bounces-233213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHIwCbroz2kS1gYAu9opvQ
	(envelope-from <stable+bounces-233213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:20:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD4396421
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04012301E05E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531D3CAE7F;
	Fri,  3 Apr 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSqLh9dz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931F92C08BB
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233204; cv=pass; b=DrUXSEdchG37rNZkGJSAw5kPZHmTfS27sN4Yz7BF34ts+B+KdH39G9Llq+Z/2FVKqLc2e5V8d2ijQ3hSHfWMAu8VLmEo4SEHXz6kHevV6WKHXPSM2DqMAwr+9sY+Wgbt4dpKOGiyJZDndGZFiv7IzvKbDE2z8/7yGdlhJmaShes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233204; c=relaxed/simple;
	bh=D1y1DSZ24fieEFS/2aK46LPRiEzKTQE6w5wGIEwhqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcnPEF0QYcqTueh5HCCaOvXCSf1wgftihLoQD1+rwiLsPETP4EHkeKtNjWcEHdiX2LRuQcdWOrThkjOtXyVxIqOgjGZ2yK+avGSzjaDFFgl/FCXmWci8ObNQRG9U/qaTz6GdQk/qMeGXWTYS6IYZNZJGilw1jxCsYPFGa4xA+qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSqLh9dz; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d556c1a79eso2438581a34.3
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 09:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233202; cv=none;
        d=google.com; s=arc-20240605;
        b=fjFrQBnv0nU3ytIJ9vE+/ez3QrW4fOi+eHAgQOgSOzbEjctbIQjaysIQmk3JKUgZCt
         cowD+p7trtBjUO+dDgHiqRSdjCyJiDwCSU6fjkV47htZCSKNYc6s5jNU50s/x9AOJhjk
         lk8Wusb9BwJh+/AT+3sMxk5TrBGMoByhnzzv6SR6UJH4qJ5tTKI9FMl2Y1DaitfJx5WU
         j3Y2lDVcvE4f7qap045G7rbZ1Yte8m82HzvOx8UnK1+Lay43vUpMmaIcng4iRM4khTlT
         mPDnK+HJfS1oGSpwV55SXx5Z/f3iK4ytGT6eQAG74X8Wc4ome4o6Cwt/sZ6g8mnkSid4
         SPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+V1E+/KFBONHYKrDP8YAiJIHIjVU2b7P8j+yHhcYHMc=;
        fh=jwc1+xZgqiu4POmtL2v3BQ62pVxtR4+/PJTpi+IlT2w=;
        b=THtR7udUebN/DCKIdsx75vB8IlWM0Th2Vuz3t67RRt8ZJ9Q/icNR1D+t6dXjD/oyyU
         aJtBQRZgCIczoAzEN9bj65PfalUncNbQvY88muGV6NoXkOp6nuk/GWw/PBW43L5Fd41j
         QH99DQ+Ul65/ihRqLaT9GGXtHKF65fS5R8tJv8FS5V2f7JJW2NOv34uTFVRyd3On6IMc
         VvBeL/4QSN2WUx18b6ONbR0mJcjm7TTrM6PdYMr8LCBHbACReRqbJpPiDm1TNnxj0FjO
         ForQnZ07LuX290g3/hAbfqSXzn+p92qjqK0Y9FdVezRlCuEQ1LxAtSKqfDYcCcdi0v+J
         vvUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233202; x=1775838002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V1E+/KFBONHYKrDP8YAiJIHIjVU2b7P8j+yHhcYHMc=;
        b=LSqLh9dzKcgeO58OJAjNLJC3lkpslDPlFFLi0iEoIZqyBUC088MzlxzECPWTAUiS/Q
         /ai81neGRzHMqoVFv9E/dqzsM5WBRYBDC82MKQ53uRrReJ6Eyp+vIOHTmMBw1clWx51X
         GkNWd/Y8Q/UfzO5ZUzosW2rjL+0EHW8bEtIGBU27hUxiCc0suA5HbmmVYEGnh9KWdNT5
         yDrqOhq1n72N9INnN6jJ2y2INxB5igtLJy+GVe7gldauZMdhN+blFzHFWnNGi3mCQHY9
         JA11P1zzhc/ujHBWispYtjoD+ug/uzJdKLloyrOpphG1RWGZxhtUNbQz/y5st88LB427
         9Dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233202; x=1775838002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+V1E+/KFBONHYKrDP8YAiJIHIjVU2b7P8j+yHhcYHMc=;
        b=hxU06df4Uyw2pGEDtllKwLk18Jhvy3a7RbcPSoeWB9YpihlhwpTk90eF3yQJN2kv/7
         BtfAB7+46rJkoUFB8l02RqPyDuFigf/L4/sU+RMwz49NeMHXtBSCHF6d0DrJBFpw8IFL
         8B+a00v9rL/50rvYOsTw4QNMtS9VASFaFSvCT1y5puIfPlw3+WBfnHh3pTNGPLlwo4qU
         smGbhvO1sv2QS+rt+4LzVmqzcE5t9BqMsEPXQN8jhAhw7WM26p10ZHl0ALfgsMkLMlW5
         xLc1AklY75J7suTA6FTgBPX2Go1D3NY75UVL5plIxDpdCzHIPKBmBICI9A2pPWPZZyj3
         BqkA==
X-Forwarded-Encrypted: i=1; AJvYcCXSgpE3zFvU/p37+9ZiRbInGspaTl0SqvnEkgpg61E5guxUwqJG7O8t/mxj8nVtVL6/22DEjso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxttd93RUxlGePmL1FUEMmQDzs0bekhOLVbOjluQ6o9o+j6p3pA
	1I7IvDa8Il/RdCxCiIh8r+RDGKXZZQOLy3snEqH4Ap2xhlwhpVzkllKeJsJvNNcCibwgaa7x8dC
	gBvBfhMtcJkGNBla5KiLq0PmWlwiYY6w=
X-Gm-Gg: ATEYQzzQegnpG0Iv8OSeHhX2xq4dh/ZYcQI/nIaIy4NtfHRGfJBvA85D8K8Xk8+9Hmg
	p5QwQCAhdvOJhrwMSmlnEn0Ed60AtT0CXI+91X5lsdT3vVCXe2OByzyLtJiD/A5PJPRohM79zlD
	t/CwnrqmnpDmRqQ4a7hCbrimPiyU2cYsgChWNAW23gb2LS5CSwlCfXvhZ7eeJlJWykBI79xjmlI
	gEQOgw08uZNsJ8exgSx/h98j4xDVaZreMixFwV0BgnpvFp3lTvfwyISv51bdfNE9Q9Dh47yjGL3
	eLLE9dc6
X-Received: by 2002:a05:6830:83ba:b0:7d9:ad90:5677 with SMTP id
 46e09a7af769-7dbb75d7260mr2353806a34.30.1775233202503; Fri, 03 Apr 2026
 09:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABb+yY0ub51k-eFpPfgARXtwYjWzRSjbPDLtoMD77YQR8JH+=Q@mail.gmail.com>
 <20260403145119.2581034-1-joonwonkang@google.com>
In-Reply-To: <20260403145119.2581034-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Fri, 3 Apr 2026 11:19:51 -0500
X-Gm-Features: AQROBzBimCWicSTdSy1XOK425eepJ2fZaf0LPQosLeZZ5fVq1iHQtw7KN5njBvw
Message-ID: <CABb+yY0uDQh-3cadPQONV=NJKjMtc4mJekgjmHYVaHnfHXvGZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
To: Joonwon Kang <joonwonkang@google.com>
Cc: angelogioacchino.delregno@collabora.com, jonathanh@nvidia.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7CD4396421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 9:51=E2=80=AFAM Joonwon Kang <joonwonkang@google.com=
> wrote:
>
> > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@googl=
e.com> wrote:
> > >
> > > Previously, a sender thread in mbox_send_message() could be woken up =
at
> > > a wrong time in blocking mode. It is because there was only a single
> > > completion for a channel whereas messages from multiple threads could=
 be
> > > sent in any order; since the shared completion could be signalled in =
any
> > > order, it could wake up a wrong sender thread.
> > >
> > > This commit resolves the false wake-up issue with the following chang=
es:
> > > - Completions are created just as many as the number of concurrent se=
nder
> > >   threads
> > > - A completion is created on a sender thread's stack
> > > - Each slot of the message queue, i.e. `msg_data`, contains a pointer=
 to
> > >   its target completion
> > > - tx_tick() signals the completion of the currently active slot of th=
e
> > >   message queue
> > >
> > I think I reviewed it already or is this happening on
> > one-channel-one-client usage? Because mailbox api does not support
> > channels shared among multiple clients.
>
> Yes, this patch is handling the one-channel-one-client usage but when tha=
t
> single channel is shared between multiple threads.

hmm.... how is this not single-channel-multiple-clients ?
A channel is returned as an opaque token to the clients, if that
client shares that with other threads - they will race.
It is the job of the original client to serialize its threads' access
to the channel.

> From my understanding, the
> discussion back then ended with how to circumvent the issue rather than w=
hether
> we will eventually solve this in the mailbox framework or not, and if yes=
, how
> we will, and if not, why.

It will be interesting to see how many current clients actually need
to share channels. If there are enough, it makes sense to implement
some helper api
on top of existing code, instead of changing its nature totally.

Thanks
Jassi

