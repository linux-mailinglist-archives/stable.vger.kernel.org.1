Return-Path: <stable+bounces-249920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDrHNSK1DWrC2QUAu9opvQ
	(envelope-from <stable+bounces-249920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:20:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547B58EAE8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 700EF301917E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E723DD52B;
	Wed, 20 May 2026 13:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inyTVbbN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4F3E2759
	for <stable@vger.kernel.org>; Wed, 20 May 2026 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282728; cv=pass; b=k4DvNA6nChCqPjB1smY7rMaoWDIX81ptHu+Vc9GV4q+HnILhHSWs9rQfIxQuHwGjMrwWQB3DB8zu92iFT0THdqRF4x2iMJ9WIFgYytUHuxh1RJJT3qrJK79UlLjVHttnjjpNZQtzmlqgdShPYl97PEuyZdct+1NhebegGO88h0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282728; c=relaxed/simple;
	bh=cKw5YCzuiQEJpUmrAp3fl4H1ttFJuOreCSz37WERLgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHgTf9oBHnoY/033REHs5F2LlUZnUVZvC9nSV+sc1Ceq+/WH6pgxV3Wy+gzJA/TAcf5fQZ42OPnyIbb6ZJxpH+ZTAJXZ4QFtVBoDZY4NNGMbqH9eAaRj3nN05in5XbVIXL0q60fKFU8pjV24wliZbzsdgP5bdwIxYyof1dQ7KGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inyTVbbN; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c24be9e4bso5076806d50.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 06:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282715; cv=none;
        d=google.com; s=arc-20240605;
        b=fJ/WXQrLpwmDuWn/Fd6XtKD7izJYvKyApax+wNIBVc5s4FtDH3irh92ttqJ3opw4Lt
         7jm83EhL48J65kHjAyewxqRnDjP59LJrBw8srJ/3jDq32n+rBUjS2IEtHHtgqfC2j4Eq
         amas1Fj3qM2IXjLnhNlIKr2dWFJW8TRDX/z+ahHHU/1jViUvvAmdsT3vJR6zH9eb6OHd
         Q9tQMT3kpSjkb+asg5VWIJdT51jUqdqRf7V8q4x9nnx3UF9D5G5r06W/v5pBIAgK1Kgr
         glaWxkpjv+x3fekNHgX2NkXo9H/+YZxs/IEMsTeM1+xZ1zxYBXugzfjZDEMECsvpszzB
         7iWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        fh=ANfsQxz2llALEUgnitoy09mosrRYtiLujrYLS6xlioc=;
        b=fAsdPh5qb/CUn0P+Q/E4gihjdw1yrzzgS8H2MtDzJBKhv31mn4g96vq20aT0Fl1A5V
         kVREa2XNCzD8i8nO0iss8G0sb4V/cp4jK0ZKPnS7ExR8aae7/kgzVgowGJwdKk/S8rdb
         ZqUiWS4xeX4TKQnQN7yWFsHFUt9TmFhxARSoKZP+FFwfLvAEaaZuMfzym9rmR62dPj7M
         RPRHyN1We7gpvYUyb0hzeTtLkUzfwoSqTVlHrd9XF2Kt11jp0j6p8BsaQBZWRnBojZdU
         +Jn/SW6FaNlr+o7tCZ2SZwMQM/X8sJ35omyUGJLjMWmSTq1MFwHlayADIdY7/TSoehGx
         yetw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282715; x=1779887515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        b=inyTVbbNzTuiposmSrNgPgMIalkPP+hJVHHhzuFz2FnpJN+87C62ww4hNucqitd41n
         4GXdGjO42oKfyUoKPDB3S1I6zU2smCjfVAPuMQBrM+6W1PSqlh8pysJH5NTdJXXlzbAg
         fs8GUIcls83VE184Zp9uY3V+3m75eZxx/u10Wd9JKPVNFvg49Eu6RGMBkWpYZ2GjKJwV
         cE/QQN5iOlKLlezblU09l8wC/z3uFqXxkRrEvProEeQqjR1LN6S3pRDpgmq0rYDlXMK3
         +g3Waq/rfSxJ/WZTvTMLy2XeBCoecpoXLg0YsifC50brRAL3r90zA7WOZe14eNBh7zfL
         dtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282715; x=1779887515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fM3pFjSA7u9dK0K2/dG7XeV5S24ISSrkdo3lpIb1ByE=;
        b=AtgPmi3LuCUGifkxyV5ATuh0n006MKRWmaeMp2a4fstXA5Nwa39BbrZLD/MnZ2l8nx
         hTDqU0cCfFJXosy0tDWo+9BSqhhnWEfLjoQh6UaP3tu71vWQW2iyxcIpAPFYQDgetsUD
         LtC7ibzgYCHKn1QT+7iQVKfuzZPz31Kkx6MQ5ehYRdOuua7JBR+yvU5T+BXHVV014KKg
         B7QFK0v9dvT9gmnuljsqniu+cnR5ObK/0Bq9FlEbH2JSlCbP+W9uqrTivv21f6ogIUei
         E5fNwGB+NuLIB9DZtlNAgY6sIzYp9TDYFo5CMt3gG3XLCchZH4APZkuw4P3wpZ5Y4xvD
         DpAw==
X-Forwarded-Encrypted: i=1; AFNElJ+a+OKlMzvW2nvVI0MhORB5X57Nmq5O/mWtQSyvHSw8qmCT7uKueGhiABfCkzWcgLEnzBtuboQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr01m3B9Zh6LvBb3W1ySyJzTxpA4nxErDlSA1b7M/2rwZsiJof
	mNBStxAjH4vKkgFvZqy2QgZAYilnEj8kpQ9ZfasiaYe7detIBxIo+3GkJickkfuLoCH0iH5NoIu
	JhjyfFmd3lN9MO3riZhnxjdUDfGYUELw=
X-Gm-Gg: Acq92OEgaJiezQVChW8Faago8iYaUfDjP+5j8Wt7S5nX/ydG49ugN4q+c5Xw4e/eqoi
	n9Nz27qFBnkCHsYJ8fGhTJQPIT/K33Dwy4BspHeILxVESEDKu6hmzUFG4HZcJ5PTUX++TthDc/u
	Xx5ko/0IipFfbWnq9irEoTwPtjmLPxuIqfz2sUjkORhF/ruz38/bi3eT6MFhhKgict3MgEp1Sim
	I87aoNw26fC/JnnwL+lt1SYrRYfsPABz8alRQM9O+ZSKYCtLFpfNIBEk8Gk+aUAzuBwOEneuY9S
	y+vRNQIxa9+xmi+ru/lZqIDt6rMl5CO14ELzk4OX6Pz3TW07UJb5oispmVfdaHPAbhv4b9bvyIb
	K8fxL
X-Received: by 2002:a53:c056:0:20b0:65c:4066:d177 with SMTP id
 956f58d0204a3-65e2264ffd7mr18238658d50.9.1779282715259; Wed, 20 May 2026
 06:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
In-Reply-To: <2026052026-barber-espresso-1d9a@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 09:11:42 -0400
X-Gm-Features: AVHnY4LMSkZgfnRrbpGkQ3oSEmfCsbIHkLmvULkOOnK2PiOJuvWBImpmmtpycYc
Message-ID: <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: August Wikerfors <git@augustwikerfors.se>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249920-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7547B58EAE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > Hi Greg,
> > >
> > > On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > >
> > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wr=
ote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wro=
te:
> > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis=
 wrote:
> > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > >
> > > > > > > > > > > The following changes since commit c78bdba7b9666020c0=
832150a4fc4c0aebc7c6ac:
> > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities (202=
6-05-14 15:17:12 +0200)
> > > > > > > > > > >
> > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > >
> > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/blue=
tooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > >
> > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a8c75=
47d088fb6275c00282:
> > > > > > > > > > >
> > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffies t=
o ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > >
> > > > > > > > > > It seems this PR sadly came too late for this week's ne=
t PR to mainline
> > > > > > > > > > that was merged yesterday.
> > > > > > > > > >
> > > > > > > > > > TWIMC, from my point of view, it would be great if we s=
omehow could
> > > > > > > > > > still get the changes from this PR or at least the btmt=
k fix it
> > > > > > > > > > contains[1] to mainline this week before -rc4, as it is=
 fixing a
> > > > > > > > > > regression known since 2026-04-24 that at least five pe=
ople encountered
> > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Blueto=
oth: btmtk:
> > > > > > > > > > validate WMT event SKB length before struct access") [0=
06b9943b982 in
> > > > > > > > > > -next].
> > > > > > > > >
> > > > > > > > > Greg, Sasha, that [1] fix I was talking about now reached=
 -next as
> > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT F=
UNC_CTRL
> > > > > > > > > events") and will likely hit mainline on Thursday or so w=
ith the weekly
> > > > > > > > > -net PR to -mainline. If that's good enough for you, I'd =
say it would be
> > > > > > > > > good to pick this up for the next round of stable kernels=
.
> > > > > > > >
> > > > > > > > That "Fixes:" tag is referring to something that is also no=
t in any
> > > > > > > > tree, but that commit does have a cc: stable in it.  So do =
we need both
> > > > > > > > of these:
> > > > > > >
> > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > >
> > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB len=
gth before struct access")
> > > > > > >
> > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c0=
8 is the
> > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluet=
ooth:
> > > > > > > btmtk: validate WMT event SKB length before struct access") -=
- the one
> > > > > > > that is causing the regression that I want to get fixed. So w=
e now only
> > > > > > > need:
> > > > > > >
> > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_=
CTRL events")
> > > > > >
> > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is goin=
g to be a
> > > > > > nightmare to track over time, ugh.
> > > > >
> > > > > Hmm, did we get the wrong hash or something? Usually, that would =
show
> > > > > up in the verify-fixes.sh, but perhaps it didn't capture it this =
time
> > > > > for some reason, perhaps I'm running an outdated version or somet=
hing
> > > > > similar.
> > > >
> > > > Something went wrong if we ended up with a patch in the stable tree=
s,
> > > > yet this fix is referring to it as a different git sha.  Don't know
> > > > where the disconnect happend :(
> > >
> > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
> > > struct access")
> > >
> > > I don't have that in any of our tree either, this is actually
> > > 634a4408c061 on all trees in the chain:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it/commit/?id=3D634a4408c061
> > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3D634a4408c061
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D634a4408c061
> > >
> > > Or actually that was the hash before it got rebased on bluetooth-next=
 tree:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-n=
ext.git/commit/?id=3D041e88fb0c08
> > >
> > > But I didn't send the PR from that three so perhaps somebody else sen=
t
> > > it to stable with the wrong fixes tag?
> > I believe the confusion comes from "Bluetooth: btmtk: accept too short =
WMT
> > FUNC_CTRL events" itself currently having different commit hashes in
> > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The former
> > correctly refers to "Bluetooth: btmtk: validate WMT event SKB length be=
fore
> > struct access" as 634a4408c061 in the Fixes tag and was merged into net
> > yesterday heading for 7.1-rc5. The latter still refers to it as
> > 041e88fb0c08. Both are now in next-20260519 but only the latter was in
> > next-20260518 which was the latest at the time of Thorsten's message.
> >
> > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 should re=
sult
> > in a valid Fixes tag.
>
> Ok, now done.  Be careful of duplicate commits in different branches
> that are marked for backporting with different ids.  It can cause
> massive confusion (i.e. don't be like the drm tree...)

Noted. I guess I need to dig into how other trees do to avoid that.
The problem seem related to using 2 trees: bluetooth->net (fixes only,
rebased on each RC) versus bluetooth-next->net-next (development,
rebased once per release).

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz

