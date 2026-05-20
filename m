Return-Path: <stable+bounces-249929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAofO//ADWr32wUAu9opvQ
	(envelope-from <stable+bounces-249929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:11:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3358F5B7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431CD3152C6B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2222BE03B;
	Wed, 20 May 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+WMwZvW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F736B055
	for <stable@vger.kernel.org>; Wed, 20 May 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285224; cv=pass; b=bQhcZsYYz/SjQ320VbLyd9bmt9OPYgPzzoHdGo1KNWhJkDKZOcVQR8RJHeswSdL/sav+5jlUiVq5k3r6kM7sMX47EUlCmnsVN96XDUvnwU/3BH4cU4tc3MNxNBoYhS5FUo6iDxp3SUqFQ2EUGUU+zH2LvgM1SC/Hu5BZ5yKK8Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285224; c=relaxed/simple;
	bh=ghMB5I3ZznM6B+uIBYnjRUhxHcZcmdpqsz9B+Q/n7tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU9qa7D6zyO2/hZNJUZuJLc1GLEDEgBiMZfS3Wtqfjy4NRMZUKWyysgMyr6RIccf6Ojz+liBNDj1nefbWYlA+vqTZEZNDtCDD+wjyFT1wTsgCWznSDsmcYA7i300eA1XlT9US83NTbZzkYUn33Gup0Nhdc/Mv1aHkNrvizCrCTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+WMwZvW; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6530287803cso4977075d50.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 06:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285222; cv=none;
        d=google.com; s=arc-20240605;
        b=FdRbEnLieiRP2zjRuMALd6VBAn58CzRlx+j6NTP1Jd0gYq9W4uMN54CbESVPkw6C0W
         Q45rN+2v2t8xIaeFR4ZM/5+tIC/NmAzSOeguyEWmFqwRLAQhY+4Njaex7YDPKF1Bh6aR
         TAnZU7c+e2J6Z7elWEqWTbCqOaEMULCoChI1uVYRFxYlCyHp171/E8KCQgVTL7vTsep4
         OOn3vj3nKSj/rEssRMX3Xr/dJN+93yL2BFat1tcqgLA6M6PWoqu/ifUY8JIHfaCa35iA
         bm1TSfHvdkXT8P8kxTH+R214KVtbk0A6nqwNlcZPR/cIBL/SZAm3gkjjtQG1s0ogWJxL
         RDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        fh=psHY2p/PYJOwauwgpef+ou9k8NYgQjroXGmdl5Sadck=;
        b=IVPf3bVn7MeaYWqkb/2RhJWdWtGCfCLNWpJMOnPeM68/5luPd/7NqRr5YQznf1ezSx
         WB4zCkdfPRZagGDUun154sJBa+DcgIDws6+C6qdEs8GPIsDRHAgdp06lgwj86L1lDrKI
         NK070xcH83b6BrVv47vZ7mTIsTx9fQ5bXsjrFrdI0D9aGQpNvJfSqak6iUroRick4AjN
         6RCQMGXDeXvV/TtJDYWHrtpZUJ6c/6AkIdCLOkOOuUuwOJMre38g94/t9/3xmUNjvTIz
         pO8ooMMPdUJEigSkrPieNWcn5R4BwrOdSxanCnsMjg6MojtYbgP2CAH5Gee/gXCcUBv5
         KmuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285222; x=1779890022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=G+WMwZvWwOAZjnjJinSzsWiknyErZJ0rmDpkLx2DfwUs0luhGtNBAFFk+5BCKOmBK0
         ofWrDt1W06hqHQPmpmok+qh4AsoP+7nG0s0OoHqOL+nciQWEuBRU/A0rjBsZkTiHIHIx
         8Z8tRQKieYPg9zwIn+0Tg9zHsNXmycGpPBj4WnGNyb/+fbSEFS+0+dndAvm1x7aE7grH
         jkZOniV01U7K8/6BLE5wlSB1YlIDXTj4TjoUoLA7jFv4FR1EC7QciKijYeCMGCPzJXc5
         MpzDPAFpHuSRgmBJfyjIay6ZSP9sNPoxEi28626XphFdQKJ+uJHZVks09mToBpXKQa6h
         Vjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285222; x=1779890022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdYtmXr5yw5qje/D1jtPFpQx5oQHNPSqQ+7yc0yfv8E=;
        b=YqNig2Fynoo6+UBC2sBitq5EJySvTbl8EKNPWc7eRwq5cD6gXLYgLomEiDWo8PQtVM
         o3eHx8DSKutfBHzo1BcOJmAgB/Hnyh8UO4PmxsH1FrxbEse/PTlfDYU0Hasd9jRmZLuN
         sr7sGO9LtlmbCP6strEFHNVsK+Tcj7qrsUkwPGAueZ5QB/CDOPH29cdkwaj3+FYr1Gaf
         1PNamEb4Fp2bip6XOCDS2PsbY4+gfV87Qy/19kaHR0DpM8mmQ4Nt5008KXDInUR+f9EE
         alVXh/gT1CBPppiU1TuRNdaND0dly9QxwAmDDGI7WEWXRqUnaEwDMXy/QSdtXKA48OdD
         qmMw==
X-Forwarded-Encrypted: i=1; AFNElJ/fmfVDvAcsq3E5dHFayBXa+4rcZ5q19UB4SR3AC4WPcIpjpUWE3SPdWmIq2N6TBJPZ41px0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcm0df7byLG50jn/2MRZ6PguIRCXcdbZHLuRIR+QqCAgefC/q9
	NY1FDypjlOUtLQDz538buzQTfkX2e4nfjP1GZcazEUXaVWDkPshhPiqh0P4ijWASLE1E5h5+Wp4
	IfUVuQYQir8jIbaaqq6imyuXDGuKLUkA=
X-Gm-Gg: Acq92OG3p2WaWXPEASl22OtKssnCQX2K2nzpFnYVLrnzOwZt5w/ymqpggrVEpASFfWo
	JJYnpKRuoQUmQ/onXXBw/7FVU2S0d7sOBlednOpOWOnfvHiNlPKGZlBtC5QW7ai/dE2zOaSCwhW
	lxbNEKVna3a+Txnx96p2AyWzp1SYksAMfM9vxm0xhsBy61e+kH6RhkTzb/zcf77TbjkOGw0Bb54
	zAlh1W5w8j6Qo07mbUqR9tEzi7NX3n/oqtru4vsIx+MS8hgOFPsUEFxWzxK49c8KsYdgkJbQAH7
	6ecreqdSRhnJixPWRwkMCAIYRMPlcoP5uiMzFuTt9eirZBl7R+GIP/U8mJvwV47FIRuLVeurV72
	vP791
X-Received: by 2002:a05:690e:4290:10b0:65c:2208:8c6a with SMTP id
 956f58d0204a3-65e227dfa70mr19056657d50.42.1779285221725; Wed, 20 May 2026
 06:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh> <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se> <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com> <2026052047-silica-grub-0bb2@gregkh>
In-Reply-To: <2026052047-silica-grub-0bb2@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 09:53:30 -0400
X-Gm-Features: AVHnY4Kvielev57YNURsHMJ5Vco21acsoY0xKleOB6jrUgrO8TFy7dJIbwvPLM0
Message-ID: <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249929-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 60F3358F5B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Wed, May 20, 2026 at 9:14=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, May 20, 2026 at 09:11:42AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Wed, May 20, 2026 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 07:37:35PM +0200, August Wikerfors wrote:
> > > > On 2026-05-19 17:49, Luiz Augusto von Dentz wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfou=
ndation.org> wrote:
> > > > > >
> > > > > > On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dent=
z wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis=
 wrote:
> > > > > > > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > > > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leem=
huis wrote:
> > > > > > > > > > > On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > > > > > > > > > On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > > The following changes since commit c78bdba7b96660=
20c0832150a4fc4c0aebc7c6ac:
> > > > > > > > > > > > >    net: phy: DP83TC811: add reading of abilities =
(2026-05-14 15:17:12 +0200)
> > > > > > > > > > > > >
> > > > > > > > > > > > > are available in the Git repository at:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    git://git.kernel.org/pub/scm/linux/kernel/git/=
bluetooth/bluetooth.git tags/for-net-2026-05-14
> > > > > > > > > > > > >
> > > > > > > > > > > > > for you to fetch changes up to 375ba7484132662a4a=
8c7547d088fb6275c00282:
> > > > > > > > > > > > >
> > > > > > > > > > > > >    Bluetooth: hci_qca: Convert timeout from jiffi=
es to ms (2026-05-14 09:58:08 -0400)
> > > > > > > > > > > >
> > > > > > > > > > > > It seems this PR sadly came too late for this week'=
s net PR to mainline
> > > > > > > > > > > > that was merged yesterday.
> > > > > > > > > > > >
> > > > > > > > > > > > TWIMC, from my point of view, it would be great if =
we somehow could
> > > > > > > > > > > > still get the changes from this PR or at least the =
btmtk fix it
> > > > > > > > > > > > contains[1] to mainline this week before -rc4, as i=
t is fixing a
> > > > > > > > > > > > regression known since 2026-04-24 that at least fiv=
e people encountered
> > > > > > > > > > > > with mainline since -rc3 due to 634a4408c0615c ("Bl=
uetooth: btmtk:
> > > > > > > > > > > > validate WMT event SKB length before struct access"=
) [006b9943b982 in
> > > > > > > > > > > > -next].
> > > > > > > > > > >
> > > > > > > > > > > Greg, Sasha, that [1] fix I was talking about now rea=
ched -next as
> > > > > > > > > > > 162b1adeb057d2 ("Bluetooth: btmtk: accept too short W=
MT FUNC_CTRL
> > > > > > > > > > > events") and will likely hit mainline on Thursday or =
so with the weekly
> > > > > > > > > > > -net PR to -mainline. If that's good enough for you, =
I'd say it would be
> > > > > > > > > > > good to pick this up for the next round of stable ker=
nels.
> > > > > > > > > >
> > > > > > > > > > That "Fixes:" tag is referring to something that is als=
o not in any
> > > > > > > > > > tree, but that commit does have a cc: stable in it.  So=
 do we need both
> > > > > > > > > > of these:
> > > > > > > > >
> > > > > > > > > Valid question, as yes, there is a slight mixup here:
> > > > > > > > >
> > > > > > > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB=
 length before struct access")
> > > > > > > > >
> > > > > > > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88f=
b0c08 is the
> > > > > > > > > -next commit-id for mainline commit-id 634a4408c0615c ("B=
luetooth:
> > > > > > > > > btmtk: validate WMT event SKB length before struct access=
") -- the one
> > > > > > > > > that is causing the regression that I want to get fixed. =
So we now only
> > > > > > > > > need:
> > > > > > > > >
> > > > > > > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT F=
UNC_CTRL events")
> > > > > > > >
> > > > > > > > Ok, but that "Fixes:" tag pointing to an invalid commit is =
going to be a
> > > > > > > > nightmare to track over time, ugh.
> > > > > > >
> > > > > > > Hmm, did we get the wrong hash or something? Usually, that wo=
uld show
> > > > > > > up in the verify-fixes.sh, but perhaps it didn't capture it t=
his time
> > > > > > > for some reason, perhaps I'm running an outdated version or s=
omething
> > > > > > > similar.
> > > > > >
> > > > > > Something went wrong if we ended up with a patch in the stable =
trees,
> > > > > > yet this fix is referring to it as a different git sha.  Don't =
know
> > > > > > where the disconnect happend :(
> > > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore
> > > > > struct access")
> > > > >
> > > > > I don't have that in any of our tree either, this is actually
> > > > > 634a4408c061 on all trees in the chain:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git/commit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/co=
mmit/?id=3D634a4408c061
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/commit/?id=3D634a4408c061
> > > > >
> > > > > Or actually that was the hash before it got rebased on bluetooth-=
next tree:
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git/commit/?id=3D041e88fb0c08
> > > > >
> > > > > But I didn't send the PR from that three so perhaps somebody else=
 sent
> > > > > it to stable with the wrong fixes tag?
> > > > I believe the confusion comes from "Bluetooth: btmtk: accept too sh=
ort WMT
> > > > FUNC_CTRL events" itself currently having different commit hashes i=
n
> > > > bluetooth (e3ac0d9f1a20) and bluetooth-next (162b1adeb057). The for=
mer
> > > > correctly refers to "Bluetooth: btmtk: validate WMT event SKB lengt=
h before
> > > > struct access" as 634a4408c061 in the Fixes tag and was merged into=
 net
> > > > yesterday heading for 7.1-rc5. The latter still refers to it as
> > > > 041e88fb0c08. Both are now in next-20260519 but only the latter was=
 in
> > > > next-20260518 which was the latest at the time of Thorsten's messag=
e.
> > > >
> > > > Greg, this means picking e3ac0d9f1a20 instead of 162b1adeb057 shoul=
d result
> > > > in a valid Fixes tag.
> > >
> > > Ok, now done.  Be careful of duplicate commits in different branches
> > > that are marked for backporting with different ids.  It can cause
> > > massive confusion (i.e. don't be like the drm tree...)
> >
> > Noted. I guess I need to dig into how other trees do to avoid that.
> > The problem seem related to using 2 trees: bluetooth->net (fixes only,
> > rebased on each RC) versus bluetooth-next->net-next (development,
> > rebased once per release).
>
> Just never rebase any public tree please.

I guess the alternative is to do merges, right? While I understand
this will not be changing the sha-ids I don't think it changes the
fact that fixes applied on the bluetooth-next cannot be merged into
bluetooth. Is there a way to retain the IDs across trees? The
alternative, I guess, would be to apply fixes to bluetooth tree and
then merge them back to bluetooth-next to preserve the IDs. This would
make the CI job slightly harder, as it would need to detect if a Fixes
tag exists; if so, it would probably need to go through the Bluetooth
tree first.

--=20
Luiz Augusto von Dentz

