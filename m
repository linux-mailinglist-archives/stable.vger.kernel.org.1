Return-Path: <stable+bounces-213098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPjvJs4OgWnmDwMAu9opvQ
	(envelope-from <stable+bounces-213098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 21:53:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D9D1524
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 21:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B13B8302AD1C
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 20:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090B63033CE;
	Mon,  2 Feb 2026 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="tNVODMtq"
X-Original-To: stable@vger.kernel.org
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEB274B35
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770065409; cv=none; b=JejPKqWqq+0U7cy2TbYkRIbzlylkKxBk5w5mkZ/sQiapO1KQTOkxekFb6yRU0BOsn3S/pC6lqy07qMchnkRX433naZrn+vy6n6n8FsAvEAYnflqTb3vA+V/kBFUspnHf02l5tE3I6dp88v8c7+rWxxBUmsH+13/YhmvJmGWoKOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770065409; c=relaxed/simple;
	bh=mg9H9F5yHPJp2fzisdbRYIC4qAhmlgFf9LgyCdIy7Fg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ah4OfVyI4U4aMBOhPfMNaCBkWa7nsCM+VW/LKMLlToEzsPhSfk1nZfb68EJGBBMun7gvoQZWEWHHu7YyRxjUt5BR3+qt2qI7+BhCXL7jaom0WpG2dNziXqGgWZTwf/XM6W+mFXROnItJlICbFI9nGBsMjvwK0PBcrCH9kCo16Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=tNVODMtq; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770065403; x=1770324603;
	bh=mg9H9F5yHPJp2fzisdbRYIC4qAhmlgFf9LgyCdIy7Fg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tNVODMtqgSDrSuVGkzD/O12xGKo2bVqGaePQnshXE92J1Jw8P595OC4CPwja1wseJ
	 OvLCUJYHjX7Of2GD0Nvp+xjkJW++herNcaraYg/NSAhPQqDltvOCXAkoRjOV3IwUKU
	 6l582l5OSo/ohTzrxIH18fcsiVDCSmwGpqZjRvZ/pMtT+1R0QSxOtP/1F+rHQ46L42
	 HW77YUJR/Xt/MuUbtf7DcGEUTaKQjK/41fDVaFBj7Jjx31bfQVI+1vc05QIGElsbSJ
	 e1CpSyieJkoXac40jHl/AjzNJF9xA0TZXdhBYkywvNN2sWLy5HOJR9qSF2xorge07U
	 +5ZTJM3LdyN3A==
Date: Mon, 02 Feb 2026 20:49:59 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
In-Reply-To: <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org> <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com> <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com> <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org> <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com> <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org> <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 73133abcbfe30135cf85dd77d7b8607584a036b6
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
	TAGGED_FROM(0.00)[bounces-213098-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,1g4.org:email,1g4.org:dkim,1g4.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF4D9D1524
X-Rspamd-Action: no action

Want to be clear, as I said before, I spent months on this before I approac=
hed.=20

The gates are programmed by a controller and used to orchestrate determinis=
tic traffic admission. This is not a simple open/close mechanism configured=
 by humans.=20

I am moving closer to IEEE not further away from.

Thanks
Paul


On Monday, February 2nd, 2026 at 8:33 AM, Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:

>=20
>=20
> On Sun, Feb 1, 2026 at 4:57=E2=80=AFAM Paul Moses p@1g4.org wrote:
>=20
> > The hardware manufacturers impose their own limits based on design cons=
traints, it's not based on the spec. iproute2's value seems arbitrary, 1024=
 comes out to be about 32 entries, based on the message length of 3112 at 1=
00 entries (this isn't counting overhead). Is page size ever less than 4k? =
May as well see what can safely fit into NLMSG_GOODSIZE at it's lowest poss=
ible value.
> >=20
> > With 4k page size, the failure point appears to be 93 entries:
> > large dump DEBUG: large dump msg_len=3D2904 cap=3D12288 entries=3D93 cy=
cle_time=3D9304278
> >=20
> > So bounding it at 64 entries or so(for now at least) would be a safe ch=
oice to maintain a margin and not impose arbitrarily low values.
>=20
>=20
> Why dont we pick some value that doesnt require changes to iproute2? Exam=
ple 32.
>=20
> > Yes, I've wanted to talk to Po for a while now. :)
>=20
>=20
> There has to be someone else, vendor, etc who is invested in this..
> That looks like magic valves to me that open/close - not sure why you
> want to do it more than once.
>=20
> cheers,
> jamal
>=20
> > Thanks,
> > Paul
> >=20
> > On Saturday, January 31st, 2026 at 11:34 AM, Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> >=20
> > > On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Paul Moses p@1g4.org wrote:
> > >=20
> > > > 1. Your script creates 100 separate gate actions, not one gate acti=
on with a large schedule.
> > > > 2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=
=9D call creates a new action, so you end up with 100 small actions.
> > > > 3. The issue I am reporting needs one single gate action that conta=
ins many sched-entry objects.
> > > > 4. Because of that, your test only exercises the dump path with man=
y small actions.
> > > > 5. The failure I see is in the GETACTION notify path, not in the ge=
neric dump batching logic.
> > > > 6. In that path, tcf_get_notify() allocates a fixed-size skb using =
NLMSG_GOODSIZE.
> > > > 7. The kernel then tries to serialize one action into that skb.
> > > > 8. If a single action contains a large gate schedule, tca_get_fill(=
) runs out of tailroom and fails, and the kernel returns -EINVAL.
> > > > 9. A single sched-entry does not exceed NLMSG_GOODSIZE.
> > > > 10. The problem is one action with many sched-entries, because the =
entire entry list is serialized into the payload of that one action.
> > > > 11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only shows=
 how many small actions were packed into each dump batch.
> > > > 12. It does not reflect the size of an individual action dump, and =
in your test each action is small.
> > > > 13. To reproduce with tc, you need one tc invocation that adds many=
 sched-entry attributes to the same gate action, and then run =E2=80=9Ctc a=
ctions get action gate index <idx>=E2=80=9D on that action.
> > > > 14. tc has it's own limit at 1024 apparently "addattr_l ERROR: mess=
age exceeded bound of 1024"
> > >=20
> > > Yes, thats the same error i was getting (with script below).
> > > ---
> > > ENTRY=3D"sched-entry open 200000000 -1 8000000 sched-entry close 1000=
00000 -1 -1 "
> > > SCHEDULE=3D$(printf "$ENTRY%.0s" {1..100})
> > > #SCHEDULE=3D$(printf "$ENTRY%.0s" {1..10})
> > >=20
> > > for i in {1..2}; do
> > > echo "Iteration: $i"
> > > tc actions add action gate clockid CLOCK_TAI $SCHEDULE
> > > done
> > > ----
> > >=20
> > > I know of no other action that exceeds this limit with all its params
> > > batched, and of course tc in userspace truncates it to about 32.
> > > Addition does succeed at 32 of those things per action.
> > > I have no idea if above is legal but it is allowed by the system.
> > >=20
> > > > I'm not opposed to gate being clamped instead of adding support for=
 large schedule sizes, but I wanted to thoroughly document why it's not pos=
sible so the next person isn't chasing a cryptic -EINVAL like I did.
> > >=20
> > > We cant have it to be infinite for sure - we will need to put an uppe=
r
> > > bound in parse_gate_list().
> > > Are you knowledgeable about this spec? I was Ccing Po Liu but his
> > > email is bouncing (so i removed him).
> > >=20
> > > So back to your first post: I agree we have an issue here. Your
> > > solution will solve the event notifications but then we will need an
> > > upper bound check. We will also need to check that same upper bound i=
n
> > > user space iproute2 code so we dont allow arbitrary values. Current
> > > number of 16 seems to work just fine - if we agree that is a "good"
> > > number (or if the specs dicate it is) then you can simply provide tha=
t
> > > fix..
> > >=20
> > > cheers,
> > > jamal
> > >=20
> > > > Thanks
> > > > Paul
> > > >=20
> > > > On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim jhs@m=
ojatatu.com wrote:
> > > >=20
> > > > > On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > > > >=20
> > > > > > .
> > > > > >=20
> > > > > > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org wr=
ote:
> > > > > >=20
> > > > > > > What version of act_gate.c are you currently testing?
> > > > > >=20
> > > > > > I am running plain ubuntu on this machine using their shipped k=
ernel 6.8.0.
> > > > > > But i did look at the latest kernel tree and the dumping code h=
as not changed.
> > > > > > +Cc Po Liu who i believe added that code.
> > > > > >=20
> > > > > > > Did you actually run the tests? =E2=80=9Clarge dump=E2=80=
=9D creates ONE action at base_index, with num_entries=3D100, then immediat=
ely does GETACTION. So =E2=80=9Ctc actions ls action gate | grep index | wc=
 -l=E2=80=9D won=E2=80=99t exercise this, because it only counts actions. I=
t doesn=E2=80=99t amplify the per action dump size (the entry list does). I=
t uses libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUF=
FER_SIZE. There is no custom netlink handling. The failure is returned by t=
he kernel before userspace parses anything. The dumps are transactional at =
the netlink level, but an individual action dump still has to fit in the sk=
b backing that message.
> > > > > >=20
> > > > > > Sorry - I am not running your code (didnt want to compile anyth=
ing on
> > > > > > this machine), just plain tc and i have to admit I dont know mu=
ch
> > > > > > about the mechanics or spec for gate, so my example is based on
> > > > > > something Po Liu posted, here's a script to add 100 entries:
> > > > > > ---
> > > > > > for i in {1..100}; do
> > > > > > echo "$i"
> > > > > > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > > > > > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > > > > > done
> > > > > > ---
> > > > > >=20
> > > > > > Then dumping:
> > > > > >=20
> > > > > > $ sudo tc actions ls action gate | grep index
> > > > > > index 1 ref 1 bind 0
> > > > > > index 2 ref 1 bind 0
> > > > > > index 3 ref 1 bind 0
> > > > > > index 4 ref 1 bind 0
> > > > > > index 5 ref 1 bind 0
> > > > > > index 6 ref 1 bind 0
> > > > > > ..
> > > > > > ...
> > > > > > ....
> > > > > > index 95 ref 1 bind 0
> > > > > > index 96 ref 1 bind 0
> > > > > > index 97 ref 1 bind 0
> > > > > > index 98 ref 1 bind 0
> > > > > > index 99 ref 1 bind 0
> > > > > > index 100 ref 1 bind 0
> > > > > > $
> > > > > >=20
> > > > > > > look at af_netlink.c
> > > > > > > /* NLMSG_GOODSIZE is small to avoid high order allocations be=
ing
> > > > > > > * required, but it makes sense to attempt a 32KiB allocation
> > > > > > > * to reduce number of system calls on dump operations, if use=
r
> > > > > > > * ever provided a big enough buffer.
> > > > > > > /
> > > > > > > ...
> > > > > > > / Trim skb to allocated size. User is expected to provide buf=
fer as
> > > > > > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped =
at
> > > > > > > * netlink_recvmsg())). dump will pack as many smaller message=
s as
> > > > > > > * could fit within the allocated skb. skb is typically alloca=
ted
> > > > > > > * with larger space than required (could be as much as near 2=
x the
> > > > > > > * requested size with align to next power of 2 approach). All=
owing
> > > > > > > * dump to use the excess space makes it difficult for a user =
to have a
> > > > > > > * reasonable static buffer based on the expected largest dump=
 of a
> > > > > > > * single netdev. The outcome is MSG_TRUNC error.
> > > > > > > */
> > > > > > >=20
> > > > > > > This is where I am currently but I have seen these bugs appea=
r throughout all my iterations including what's in the tree currently, if y=
ou show me better alternatives that solve my problems, I'll gladly accept.
> > > > > > > https://github.com/torvalds/linux/compare/master...jopamo:lin=
ux:net-stable-upstream-v4
> > > > > >=20
> > > > > > I dont see a problem with "dump" as you seem to be suggesting. =
I asked
> > > > > > earlier if it is possible that you can create some single entry=
 - not
> > > > > > 100 as shown above that will consume more than NLMSG_GOODSIZE? =
My
> > > > > > limited knowledge is not helping me see such a scenario.
> > > > >=20
> > > > > Aha. I think there is a terminology mixup ;->
> > > > >=20
> > > > > "dump" (a very unfortunate use of that word in the netlink world =
;->)
> > > > >=20
> > > > > is a very special word. So when you take a dump in this world you=
 are
> > > > > GETing a whole table. In this case all the gate actions.
> > > > >=20
> > > > > If i am not mistaken in your case this is not a dump - rather, yo=
u are
> > > > > CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
> > > > > suspected. I dont believe iproute2 will allow you to do that.
> > > > > What's happening then is that the generated netlink event notific=
ation
> > > > > for that single entry is too big to fit in NLMSG_GOODSIZE.
> > > > > Let me try to craft something for that...
> > > > >=20
> > > > > cheers,
> > > > > jamal

