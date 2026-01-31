Return-Path: <stable+bounces-212953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC7JHns5fmn7WQIAu9opvQ
	(envelope-from <stable+bounces-212953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:18:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0763C32A5
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9EE301D33A
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262E348445;
	Sat, 31 Jan 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="n7fQcUve"
X-Original-To: stable@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0F349B06
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879906; cv=none; b=VzWi94y1XpxUfWvCNJSDDxT4lhtnsyo2X2wYS1bFvyxceVvXxnKqPporkOOSAKZc9P4XyjVoeRf9556U8013QAZ2JwkxbK6Meh9PhQaLL4tc2G+SFej00CtrEIwDxn1I2xStZghqI59xbzidGqmpuI8/FR8TakrqdkiimZUnKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879906; c=relaxed/simple;
	bh=/TkOQGchM66F3gOA8TWfrK7sewXmnSyDisuWvpdNpTI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+/kGLdtcJbww9ZtCt29PeKe3tzu6L968iFF7PryANtXLRBACDPBMvKORWD+vdmloB/xKnWanQRDUl/gw0hAck+Oy0rw3dahCiff7Nzj8F9oogGPzlhztCcI7Ew7weX5g2Mb+DJdgGjujliG57H8LEeyXGpwLAYtTxp8elO4OSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=n7fQcUve; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769879900; x=1770139100;
	bh=/TkOQGchM66F3gOA8TWfrK7sewXmnSyDisuWvpdNpTI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=n7fQcUveggFTIBk8Wxc/LOpujkQ4LBPU+hdAcNflu3c4iIM4O6VVZcaQL9zhtGXCc
	 GcOa4KWlQE+ivEfWi2iDOuSsWA1ly/cxC6HVP1KNshNzkE3D/Rm7KrNrdeTe8y2DDq
	 +N9jd0TtSG1ifJqLS/nws1Hwep05gE7DIzmT+ctFX+jKFsrRRk1DmuGaZLEuj5ybkt
	 eDCvW1aY9Uq88MOaYkb3tOFAK6TCZl/vM20YFuvw2B8xNoL6vBcrbxqyfVcq6wectr
	 nzwwZmsNerb+bIRhy2bCPwq6Jm7Aq/9SULBXTOVcqDZKSGquSTlxXqr10kO+dDg8Pc
	 S9Cj0Kgxl72qg==
Date: Sat, 31 Jan 2026 17:18:16 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Po Liu <Po.Liu@nxp.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
In-Reply-To: <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com> <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org> <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com> <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: aef02823bc64f2c0d3fa85ecfd4f31cc27086972
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212953-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: F0763C32A5
X-Rspamd-Action: no action

1. Your script creates 100 separate gate actions, not one gate action with =
a large schedule.
2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=9D call crea=
tes a new action, so you end up with 100 small actions.
3. The issue I am reporting needs one single gate action that contains many=
 sched-entry objects.
4. Because of that, your test only exercises the dump path with many small =
actions.
5. The failure I see is in the GETACTION notify path, not in the generic du=
mp batching logic.
6. In that path, tcf_get_notify() allocates a fixed-size skb using NLMSG_GO=
ODSIZE.
7. The kernel then tries to serialize one action into that skb.
8. If a single action contains a large gate schedule, tca_get_fill() runs o=
ut of tailroom and fails, and the kernel returns -EINVAL.
9. A single sched-entry does not exceed NLMSG_GOODSIZE.
10. The problem is one action with many sched-entries, because the entire e=
ntry list is serialized into the payload of that one action.
11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only shows how man=
y small actions were packed into each dump batch.
12. It does not reflect the size of an individual action dump, and in your =
test each action is small.
13. To reproduce with tc, you need one tc invocation that adds many sched-e=
ntry attributes to the same gate action, and then run =E2=80=9Ctc actions g=
et action gate index <idx>=E2=80=9D on that action.
14. tc has it's own limit at 1024 apparently "addattr_l ERROR: message exce=
eded bound of 1024"


I'm not opposed to gate being clamped instead of adding support for large s=
chedule sizes, but I wanted to thoroughly document why it's not possible so=
 the next person isn't chasing a cryptic -EINVAL like I did.

Thanks
Paul




On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:

>=20
>=20
> On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@mojatatu.co=
m wrote:
>=20
> > .
> >=20
> > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >=20
> > > What version of act_gate.c are you currently testing?
> >=20
> > I am running plain ubuntu on this machine using their shipped kernel 6.=
8.0.
> > But i did look at the latest kernel tree and the dumping code has not c=
hanged.
> > +Cc Po Liu who i believe added that code.
> >=20
> > > Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D creates =
ONE action at base_index, with num_entries=3D100, then immediately does GET=
ACTION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=
=9D won=E2=80=99t exercise this, because it only counts actions. It doesn=
=E2=80=99t amplify the per action dump size (the entry list does). It uses =
libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZ=
E. There is no custom netlink handling. The failure is returned by the kern=
el before userspace parses anything. The dumps are transactional at the net=
link level, but an individual action dump still has to fit in the skb backi=
ng that message.
> >=20
> > Sorry - I am not running your code (didnt want to compile anything on
> > this machine), just plain tc and i have to admit I dont know much
> > about the mechanics or spec for gate, so my example is based on
> > something Po Liu posted, here's a script to add 100 entries:
> > ---
> > for i in {1..100}; do
> > echo "$i"
> > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > done
> > ---
> >=20
> > Then dumping:
> >=20
> > $ sudo tc actions ls action gate | grep index
> > index 1 ref 1 bind 0
> > index 2 ref 1 bind 0
> > index 3 ref 1 bind 0
> > index 4 ref 1 bind 0
> > index 5 ref 1 bind 0
> > index 6 ref 1 bind 0
> > ..
> > ...
> > ....
> > index 95 ref 1 bind 0
> > index 96 ref 1 bind 0
> > index 97 ref 1 bind 0
> > index 98 ref 1 bind 0
> > index 99 ref 1 bind 0
> > index 100 ref 1 bind 0
> > $
> >=20
> > > look at af_netlink.c
> > > /* NLMSG_GOODSIZE is small to avoid high order allocations being
> > > * required, but it makes sense to attempt a 32KiB allocation
> > > * to reduce number of system calls on dump operations, if user
> > > * ever provided a big enough buffer.
> > > /
> > > ...
> > > / Trim skb to allocated size. User is expected to provide buffer as
> > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
> > > * netlink_recvmsg())). dump will pack as many smaller messages as
> > > * could fit within the allocated skb. skb is typically allocated
> > > * with larger space than required (could be as much as near 2x the
> > > * requested size with align to next power of 2 approach). Allowing
> > > * dump to use the excess space makes it difficult for a user to have =
a
> > > * reasonable static buffer based on the expected largest dump of a
> > > * single netdev. The outcome is MSG_TRUNC error.
> > > */
> > >=20
> > > This is where I am currently but I have seen these bugs appear throug=
hout all my iterations including what's in the tree currently, if you show =
me better alternatives that solve my problems, I'll gladly accept.
> > > https://github.com/torvalds/linux/compare/master...jopamo:linux:net-s=
table-upstream-v4
> >=20
> > I dont see a problem with "dump" as you seem to be suggesting. I asked
> > earlier if it is possible that you can create some single entry - not
> > 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> > limited knowledge is not helping me see such a scenario.
>=20
>=20
> Aha. I think there is a terminology mixup ;->
>=20
> "dump" (a very unfortunate use of that word in the netlink world ;->)
>=20
> is a very special word. So when you take a dump in this world you are
> GETing a whole table. In this case all the gate actions.
>=20
> If i am not mistaken in your case this is not a dump - rather, you are
> CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
> suspected. I dont believe iproute2 will allow you to do that.
> What's happening then is that the generated netlink event notification
> for that single entry is too big to fit in NLMSG_GOODSIZE.
> Let me try to craft something for that...
>=20
> cheers,
> jamal

