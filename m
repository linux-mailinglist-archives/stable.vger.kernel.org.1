Return-Path: <stable+bounces-212989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ChkLpojf2mNkgIAu9opvQ
	(envelope-from <stable+bounces-212989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 10:57:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 634DBC55E7
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 10:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C85813011F1F
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF006321F5F;
	Sun,  1 Feb 2026 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="fNMtIEgH"
X-Original-To: stable@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DABE2E5D17
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769939858; cv=none; b=DlhOG+2aaiAJtXMBmbFx8BDQ856NlxanT5YwnR7VYY/ZYErRlWMmVGQsnbSSYgDz0e/KaedhcqYhs5k6JhXTa53JWmQ2Glr7y/pVUOJNgrB0PMIApQxhZQZxNhh/4WtbzuxkaFEkQqbhnwjEizRm2maNiC4KrbeTFV4uOIRPKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769939858; c=relaxed/simple;
	bh=flXEdHwjxkGScAa7GK97P4EiLD0xHdcI0MkIrDDvZjM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtV+DbC7erB1BSp20/okTLoNV83CB09Yr7Pbq1iw/iMneOz0WZS5ENTgnmsgBMBNR+fcG5KDuG0MLB6Kvt5cMHOrRf0OfOFPBC1zsTOIr1v9l3UIs8E8zxdJ6qcr6RHwNrzOeb3Jk36hCWP9CneOPcHl1U8oUWPgmK4Dea2gzzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=fNMtIEgH; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769939851; x=1770199051;
	bh=3DfGMQeU33SAjrGMEm6B6cit5OEu673p4hzMSfBIWiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fNMtIEgH2FLHNu7rry5AFEaI6nuCI3JkNZnu1GyzhKD7IEQS+DEIECrQsTXNYQvJK
	 mYNGL6n/OqcVd7b5LEuOncBqm5VLRAEerWSTbsQcYsD49+rufPPNLTeINZCtre7zH2
	 qGK1HOZuHfM8yKOU+vw74v7pt1Soec5M1fsNpWQcflwZ1oB3jltcMZHCATUWhF434m
	 6LzUrl7Nj4u6RfdCwk8he14m3ONRt5DJpwlUufdsqTk8+2kESw00DPrdaBtM0QdRRP
	 Rrq0NCQ/MRHRVRQg7SGC2WrM+ZWg0CiJK9+upA2C0ubu4fau8we3YoN/LtLK63RsXM
	 fXTL8LHqt9CaA==
Date: Sun, 01 Feb 2026 09:57:25 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
In-Reply-To: <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com> <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org> <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com> <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com> <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org> <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: cf8f9d6733f67ebd79bd69c4bc1081034048b645
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-212989-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 634DBC55E7
X-Rspamd-Action: no action

The hardware manufacturers impose their own limits based on design constrai=
nts, it's not based on the spec. iproute2's value seems arbitrary, 1024 com=
es out to be about 32 entries, based on the message length of 3112 at 100 e=
ntries (this isn't counting overhead). Is page size ever less than 4k? May =
as well see what can safely fit into NLMSG_GOODSIZE at it's lowest possible=
 value.

With 4k page size, the failure point appears to be 93 entries:
  large dump                     DEBUG: large dump msg_len=3D2904 cap=3D122=
88 entries=3D93 cycle_time=3D9304278

So bounding it at 64 entries or so(for now at least) would be a safe choice=
 to maintain a margin and not impose arbitrarily low values.

Yes, I've wanted to talk to Po for a while now. :)

Thanks,
Paul

On Saturday, January 31st, 2026 at 11:34 AM, Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:

>=20
>=20
> On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Paul Moses p@1g4.org wrote:
>=20
> > 1. Your script creates 100 separate gate actions, not one gate action w=
ith a large schedule.
> > 2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=9D call =
creates a new action, so you end up with 100 small actions.
> > 3. The issue I am reporting needs one single gate action that contains =
many sched-entry objects.
> > 4. Because of that, your test only exercises the dump path with many sm=
all actions.
> > 5. The failure I see is in the GETACTION notify path, not in the generi=
c dump batching logic.
> > 6. In that path, tcf_get_notify() allocates a fixed-size skb using NLMS=
G_GOODSIZE.
> > 7. The kernel then tries to serialize one action into that skb.
> > 8. If a single action contains a large gate schedule, tca_get_fill() ru=
ns out of tailroom and fails, and the kernel returns -EINVAL.
> > 9. A single sched-entry does not exceed NLMSG_GOODSIZE.
> > 10. The problem is one action with many sched-entries, because the enti=
re entry list is serialized into the payload of that one action.
> > 11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only shows how=
 many small actions were packed into each dump batch.
> > 12. It does not reflect the size of an individual action dump, and in y=
our test each action is small.
> > 13. To reproduce with tc, you need one tc invocation that adds many sch=
ed-entry attributes to the same gate action, and then run =E2=80=9Ctc actio=
ns get action gate index <idx>=E2=80=9D on that action.
> > 14. tc has it's own limit at 1024 apparently "addattr_l ERROR: message =
exceeded bound of 1024"
>=20
>=20
> Yes, thats the same error i was getting (with script below).
> ---
> ENTRY=3D"sched-entry open 200000000 -1 8000000 sched-entry close 10000000=
0 -1 -1 "
> SCHEDULE=3D$(printf "$ENTRY%.0s" {1..100})
> #SCHEDULE=3D$(printf "$ENTRY%.0s" {1..10})
>=20
> for i in {1..2}; do
> echo "Iteration: $i"
> tc actions add action gate clockid CLOCK_TAI $SCHEDULE
> done
> ----
>=20
> I know of no other action that exceeds this limit with all its params
> batched, and of course tc in userspace truncates it to about 32.
> Addition does succeed at 32 of those things per action.
> I have no idea if above is legal but it is allowed by the system.
>=20
> > I'm not opposed to gate being clamped instead of adding support for lar=
ge schedule sizes, but I wanted to thoroughly document why it's not possibl=
e so the next person isn't chasing a cryptic -EINVAL like I did.
>=20
>=20
> We cant have it to be infinite for sure - we will need to put an upper
> bound in parse_gate_list().
> Are you knowledgeable about this spec? I was Ccing Po Liu but his
> email is bouncing (so i removed him).
>=20
> So back to your first post: I agree we have an issue here. Your
> solution will solve the event notifications but then we will need an
> upper bound check. We will also need to check that same upper bound in
> user space iproute2 code so we dont allow arbitrary values. Current
> number of 16 seems to work just fine - if we agree that is a "good"
> number (or if the specs dicate it is) then you can simply provide that
> fix..
>=20
> cheers,
> jamal
>=20
> > Thanks
> > Paul
> >=20
> > On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> >=20
> > > On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@mojatat=
u.com wrote:
> > >=20
> > > > .
> > > >=20
> > > > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > > >=20
> > > > > What version of act_gate.c are you currently testing?
> > > >=20
> > > > I am running plain ubuntu on this machine using their shipped kerne=
l 6.8.0.
> > > > But i did look at the latest kernel tree and the dumping code has n=
ot changed.
> > > > +Cc Po Liu who i believe added that code.
> > > >=20
> > > > > Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D crea=
tes ONE action at base_index, with num_entries=3D100, then immediately does=
 GETACTION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=
=E2=80=9D won=E2=80=99t exercise this, because it only counts actions. It d=
oesn=E2=80=99t amplify the per action dump size (the entry list does). It u=
ses libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER=
_SIZE. There is no custom netlink handling. The failure is returned by the =
kernel before userspace parses anything. The dumps are transactional at the=
 netlink level, but an individual action dump still has to fit in the skb b=
acking that message.
> > > >=20
> > > > Sorry - I am not running your code (didnt want to compile anything =
on
> > > > this machine), just plain tc and i have to admit I dont know much
> > > > about the mechanics or spec for gate, so my example is based on
> > > > something Po Liu posted, here's a script to add 100 entries:
> > > > ---
> > > > for i in {1..100}; do
> > > > echo "$i"
> > > > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > > > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > > > done
> > > > ---
> > > >=20
> > > > Then dumping:
> > > >=20
> > > > $ sudo tc actions ls action gate | grep index
> > > > index 1 ref 1 bind 0
> > > > index 2 ref 1 bind 0
> > > > index 3 ref 1 bind 0
> > > > index 4 ref 1 bind 0
> > > > index 5 ref 1 bind 0
> > > > index 6 ref 1 bind 0
> > > > ..
> > > > ...
> > > > ....
> > > > index 95 ref 1 bind 0
> > > > index 96 ref 1 bind 0
> > > > index 97 ref 1 bind 0
> > > > index 98 ref 1 bind 0
> > > > index 99 ref 1 bind 0
> > > > index 100 ref 1 bind 0
> > > > $
> > > >=20
> > > > > look at af_netlink.c
> > > > > /* NLMSG_GOODSIZE is small to avoid high order allocations being
> > > > > * required, but it makes sense to attempt a 32KiB allocation
> > > > > * to reduce number of system calls on dump operations, if user
> > > > > * ever provided a big enough buffer.
> > > > > /
> > > > > ...
> > > > > / Trim skb to allocated size. User is expected to provide buffer =
as
> > > > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
> > > > > * netlink_recvmsg())). dump will pack as many smaller messages as
> > > > > * could fit within the allocated skb. skb is typically allocated
> > > > > * with larger space than required (could be as much as near 2x th=
e
> > > > > * requested size with align to next power of 2 approach). Allowin=
g
> > > > > * dump to use the excess space makes it difficult for a user to h=
ave a
> > > > > * reasonable static buffer based on the expected largest dump of =
a
> > > > > * single netdev. The outcome is MSG_TRUNC error.
> > > > > */
> > > > >=20
> > > > > This is where I am currently but I have seen these bugs appear th=
roughout all my iterations including what's in the tree currently, if you s=
how me better alternatives that solve my problems, I'll gladly accept.
> > > > > https://github.com/torvalds/linux/compare/master...jopamo:linux:n=
et-stable-upstream-v4
> > > >=20
> > > > I dont see a problem with "dump" as you seem to be suggesting. I as=
ked
> > > > earlier if it is possible that you can create some single entry - n=
ot
> > > > 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> > > > limited knowledge is not helping me see such a scenario.
> > >=20
> > > Aha. I think there is a terminology mixup ;->
> > >=20
> > > "dump" (a very unfortunate use of that word in the netlink world ;->)
> > >=20
> > > is a very special word. So when you take a dump in this world you are
> > > GETing a whole table. In this case all the gate actions.
> > >=20
> > > If i am not mistaken in your case this is not a dump - rather, you ar=
e
> > > CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
> > > suspected. I dont believe iproute2 will allow you to do that.
> > > What's happening then is that the generated netlink event notificatio=
n
> > > for that single entry is too big to fit in NLMSG_GOODSIZE.
> > > Let me try to craft something for that...
> > >=20
> > > cheers,
> > > jamal

