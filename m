Return-Path: <stable+bounces-214489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIUjBdW0hGk54wMAu9opvQ
	(envelope-from <stable+bounces-214489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:18:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDBF4856
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94210305EC1C
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593E84219EA;
	Thu,  5 Feb 2026 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="Emw/y41L"
X-Original-To: stable@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61874219E1;
	Thu,  5 Feb 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304406; cv=none; b=gDyCpqxR8uDkuGhaIeeRVia0TGwvsVRWuR92bYXBX1dhXHaE8Vrb9xMgRMYBQrKYlQa8EmnOIU9y1bCKIKWsXsD/tUb5CjDZa85eXvWWb6eWe5s7GG1BSEBlu+xJi31jX1xkscLqFck5FXWBs44X14pexgyg+qo8HMqJgo4mKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304406; c=relaxed/simple;
	bh=HjlPTj1Mga9sB4jisxoCSnsOWAbWV8YMt0zVtcsvEDg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVDZ5vDarFhDgvt47Ip8ML71geGXLTTq5MpjpslSKOK4JKj4naUgVapn9y9TK67yN5DgALIB6mFyPI7XFAWgR7k+s08XX+KvZgLXeNAsaSmyt+E3Rj35VMrudmcehLrsdXTmRXno1gLEwxZEyyp6QhBKdtsQAkB4/66j2BAG5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=Emw/y41L; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1770304389; x=1770563589;
	bh=CCGkCEdp2qbxCSXn9zNQw+aUlWniIPd5t2p2UcrJwDs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Emw/y41Ld5iWAFH9p+eHQf9s0zKz9hPgSYJyTH4dJwduSGL5Occ7+SYeRvNevmeGo
	 kfhPJm4c2BsYGHCv5VdTDXNl6fv0teIGpBTjRPof4wwQQyiZMQiPbxeg9FacSlbJdd
	 98PkHKedxOzn4Ukj8l1FUQKTB4JtjQ6NfN2YRoP5gB/4VC0pZ/EoGqGZZhItwq8bqT
	 anvEDqlTkCXu3TP+buAvtvJJ+cgJY+wCFMkT72HZSdDdJGpSAwEGnImv7J2Sapk/Vt
	 WnMZVVQiV1M7t9jypN7EV/3J+QFnCOUDVic3pOaTyz4fyTwOTaogsV+aEecLjnFPjg
	 h/n55Imm92jxQ==
Date: Thu, 05 Feb 2026 15:13:07 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
Message-ID: <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
In-Reply-To: <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org> <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com> <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com> <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org> <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com> <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org> <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com> <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 190369decd2f873ac53d785b2abb7d8a07169aaa
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-214489-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[1g4.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 89FDBF4856
X-Rspamd-Action: no action

Looks like pedit might also affected. Hopefully this makes it more clear. G=
oing to wait on more input before doing anything else with this.

NLMSG_GOODSIZE =3D SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192))
SKB_WITH_OVERHEAD(X) =3D X - SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
nla_total_size(payload) =3D NLA_ALIGN(NLA_HDRLEN + payload), with NLA_HDRLE=
N =3D 4 and 4 byte alignment

Per entry size for the gate list:

Each entry is a nested TCA_GATE_ONE_ENTRY plus five attributes:

TCA_GATE_ONE_ENTRY (nest, no payload) -> 4
INDEX (u32) -> 8
GATE (flag, no payload) -> 4
INTERVAL (u32) -> 8
MAX_OCTETS (s32) -> 8
IPV (s32) -> 8

So one entry is:

entry_sz =3D 4 + 8 + 4 + 8 + 8 + 8 =3D 40 bytes

Fixed overhead for one act_gate dump:

1. Action wrapper (RTM_GETACTION):

NLMSG_HDRLEN + sizeof(struct tcamsg) + nla_total_size(0)
=3D 16 + 4 + 4 =3D 24 bytes

2. Action shared attributes emitted by tcf_action_dump_1, baseline only
   (no cookie, no HW stats, no flags):

TCA_ACT_KIND (IFNAMSIZ) =3D 20
TCA_ACT_STATS nest =3D 4
TCA_STATS_BASIC =3D 20
TCA_STATS_PKT64 =3D 12
TCA_STATS_QUEUE =3D 24
TCA_ACT_OPTIONS nest =3D 4
TCA_GACT_TM =3D 36
TCA_ACT_IN_HW_COUNT =3D 8
action number nest =3D 4

Total shared baseline =3D 156 bytes

Optional shared attributes, only if present:

TCA_ACT_HW_STATS =3D +12
TCA_ACT_USED_HW_STATS =3D +12
TCA_ACT_FLAGS =3D +12
TCA_ACT_COOKIE =3D +nla_total_size(cookie_len)

3. Gate specific attributes inside options, fixed part including TM:

TCA_GATE_PARMS =3D 24
BASE_TIME =3D 12
CYCLE_TIME =3D 12
CYCLE_TIME_EXT =3D 12
CLOCKID =3D 8
FLAGS =3D 8
PRIORITY =3D 8
ENTRY_LIST nest =3D 4
TCA_GATE_TM =3D 36

Total gate baseline =3D 124 bytes

4. 64 bit alignment padding, only when
   !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS

There are 7 attributes that trigger the 64 bit padding:
-three stats blocks, three time values and the gate TM
-Each adds 4 bytes, so add 28 bytes in that case

Putting it together:

fixed =3D 24 (wrapper) + 156 (shared baseline) + 124 (gate baseline)
fixed =3D 304 bytes

opt =3D nla_total_size(cookie_len)
+ 12 for each of HW_STATS, USED_HW_STATS and FLAGS if present
+ 28 if unaligned access padding is required

The maximum number of entries that fit in a single skb is:

Nmax =3D floor((NLMSG_GOODSIZE - fixed - opt) / 40)

If PAGE_SIZE =3D 4096 and sizeof(struct skb_shared_info) =3D 320:

NLMSG_GOODSIZE =3D 4096 - 320 =3D 3776
Nmax =3D floor((3776 - 304) / 40) =3D 86

8192:

NLMSG_GOODSIZE =3D 8192 - 320 =3D 7872
Nmax =3D floor((7872 - 304) / 40) =3D 189

Thanks,
Paul


On Monday, February 2nd, 2026 at 2:49 PM, Paul Moses <p@1g4.org> wrote:

>
>
> Want to be clear, as I said before, I spent months on this before I appro=
ached.
>
> The gates are programmed by a controller and used to orchestrate determin=
istic traffic admission. This is not a simple open/close mechanism configur=
ed by humans.
>
> I am moving closer to IEEE not further away from.
>
> Thanks
> Paul
>
>
> On Monday, February 2nd, 2026 at 8:33 AM, Jamal Hadi Salim jhs@mojatatu.c=
om wrote:
>
> > On Sun, Feb 1, 2026 at 4:57=E2=80=AFAM Paul Moses p@1g4.org wrote:
> >
> > > The hardware manufacturers impose their own limits based on design co=
nstraints, it's not based on the spec. iproute2's value seems arbitrary, 10=
24 comes out to be about 32 entries, based on the message length of 3112 at=
 100 entries (this isn't counting overhead). Is page size ever less than 4k=
? May as well see what can safely fit into NLMSG_GOODSIZE at it's lowest po=
ssible value.
> > >
> > > With 4k page size, the failure point appears to be 93 entries:
> > > large dump DEBUG: large dump msg_len=3D2904 cap=3D12288 entries=3D93 =
cycle_time=3D9304278
> > >
> > > So bounding it at 64 entries or so(for now at least) would be a safe =
choice to maintain a margin and not impose arbitrarily low values.
> >
> > Why dont we pick some value that doesnt require changes to iproute2? Ex=
ample 32.
> >
> > > Yes, I've wanted to talk to Po for a while now. :)
> >
> > There has to be someone else, vendor, etc who is invested in this..
> > That looks like magic valves to me that open/close - not sure why you
> > want to do it more than once.
> >
> > cheers,
> > jamal
> >
> > > Thanks,
> > > Paul
> > >
> > > On Saturday, January 31st, 2026 at 11:34 AM, Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > >
> > > > On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Paul Moses p@1g4.org wrote=
:
> > > >
> > > > > 1. Your script creates 100 separate gate actions, not one gate ac=
tion with a large schedule.
> > > > > 2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=
=9D call creates a new action, so you end up with 100 small actions.
> > > > > 3. The issue I am reporting needs one single gate action that con=
tains many sched-entry objects.
> > > > > 4. Because of that, your test only exercises the dump path with m=
any small actions.
> > > > > 5. The failure I see is in the GETACTION notify path, not in the =
generic dump batching logic.
> > > > > 6. In that path, tcf_get_notify() allocates a fixed-size skb usin=
g NLMSG_GOODSIZE.
> > > > > 7. The kernel then tries to serialize one action into that skb.
> > > > > 8. If a single action contains a large gate schedule, tca_get_fil=
l() runs out of tailroom and fails, and the kernel returns -EINVAL.
> > > > > 9. A single sched-entry does not exceed NLMSG_GOODSIZE.
> > > > > 10. The problem is one action with many sched-entries, because th=
e entire entry list is serialized into the payload of that one action.
> > > > > 11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only sho=
ws how many small actions were packed into each dump batch.
> > > > > 12. It does not reflect the size of an individual action dump, an=
d in your test each action is small.
> > > > > 13. To reproduce with tc, you need one tc invocation that adds ma=
ny sched-entry attributes to the same gate action, and then run =E2=80=
=9Ctc actions get action gate index <idx>=E2=80=9D on that action.
> > > > > 14. tc has it's own limit at 1024 apparently "addattr_l ERROR: me=
ssage exceeded bound of 1024"
> > > >
> > > > Yes, thats the same error i was getting (with script below).
> > > > ---
> > > > ENTRY=3D"sched-entry open 200000000 -1 8000000 sched-entry close 10=
0000000 -1 -1 "
> > > > SCHEDULE=3D$(printf "$ENTRY%.0s" {1..100})
> > > > #SCHEDULE=3D$(printf "$ENTRY%.0s" {1..10})
> > > >
> > > > for i in {1..2}; do
> > > > echo "Iteration: $i"
> > > > tc actions add action gate clockid CLOCK_TAI $SCHEDULE
> > > > done
> > > > ----
> > > >
> > > > I know of no other action that exceeds this limit with all its para=
ms
> > > > batched, and of course tc in userspace truncates it to about 32.
> > > > Addition does succeed at 32 of those things per action.
> > > > I have no idea if above is legal but it is allowed by the system.
> > > >
> > > > > I'm not opposed to gate being clamped instead of adding support f=
or large schedule sizes, but I wanted to thoroughly document why it's not p=
ossible so the next person isn't chasing a cryptic -EINVAL like I did.
> > > >
> > > > We cant have it to be infinite for sure - we will need to put an up=
per
> > > > bound in parse_gate_list().
> > > > Are you knowledgeable about this spec? I was Ccing Po Liu but his
> > > > email is bouncing (so i removed him).
> > > >
> > > > So back to your first post: I agree we have an issue here. Your
> > > > solution will solve the event notifications but then we will need a=
n
> > > > upper bound check. We will also need to check that same upper bound=
 in
> > > > user space iproute2 code so we dont allow arbitrary values. Current
> > > > number of 16 seems to work just fine - if we agree that is a "good"
> > > > number (or if the specs dicate it is) then you can simply provide t=
hat
> > > > fix..
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > > > > Thanks
> > > > > Paul
> > > > >
> > > > > On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim jhs=
@mojatatu.com wrote:
> > > > >
> > > > > > On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@m=
ojatatu.com wrote:
> > > > > >
> > > > > > > .
> > > > > > >
> > > > > > > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org =
wrote:
> > > > > > >
> > > > > > > > What version of act_gate.c are you currently testing?
> > > > > > >
> > > > > > > I am running plain ubuntu on this machine using their shipped=
 kernel 6.8.0.
> > > > > > > But i did look at the latest kernel tree and the dumping code=
 has not changed.
> > > > > > > +Cc Po Liu who i believe added that code.
> > > > > > >
> > > > > > > > Did you actually run the tests? =E2=80=9Clarge dump=
=E2=80=9D creates ONE action at base_index, with num_entries=3D100, then im=
mediately does GETACTION. So =E2=80=9Ctc actions ls action gate | grep inde=
x | wc -l=E2=80=9D won=E2=80=99t exercise this, because it only counts acti=
ons. It doesn=E2=80=99t amplify the per action dump size (the entry list do=
es). It uses libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCK=
ET_BUFFER_SIZE. There is no custom netlink handling. The failure is returne=
d by the kernel before userspace parses anything. The dumps are transaction=
al at the netlink level, but an individual action dump still has to fit in =
the skb backing that message.
> > > > > > >
> > > > > > > Sorry - I am not running your code (didnt want to compile any=
thing on
> > > > > > > this machine), just plain tc and i have to admit I dont know =
much
> > > > > > > about the mechanics or spec for gate, so my example is based =
on
> > > > > > > something Po Liu posted, here's a script to add 100 entries:
> > > > > > > ---
> > > > > > > for i in {1..100}; do
> > > > > > > echo "$i"
> > > > > > > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > > > > > > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > > > > > > done
> > > > > > > ---
> > > > > > >
> > > > > > > Then dumping:
> > > > > > >
> > > > > > > $ sudo tc actions ls action gate | grep index
> > > > > > > index 1 ref 1 bind 0
> > > > > > > index 2 ref 1 bind 0
> > > > > > > index 3 ref 1 bind 0
> > > > > > > index 4 ref 1 bind 0
> > > > > > > index 5 ref 1 bind 0
> > > > > > > index 6 ref 1 bind 0
> > > > > > > ..
> > > > > > > ...
> > > > > > > ....
> > > > > > > index 95 ref 1 bind 0
> > > > > > > index 96 ref 1 bind 0
> > > > > > > index 97 ref 1 bind 0
> > > > > > > index 98 ref 1 bind 0
> > > > > > > index 99 ref 1 bind 0
> > > > > > > index 100 ref 1 bind 0
> > > > > > > $
> > > > > > >
> > > > > > > > look at af_netlink.c
> > > > > > > > /* NLMSG_GOODSIZE is small to avoid high order allocations =
being
> > > > > > > > * required, but it makes sense to attempt a 32KiB allocatio=
n
> > > > > > > > * to reduce number of system calls on dump operations, if u=
ser
> > > > > > > > * ever provided a big enough buffer.
> > > > > > > > /
> > > > > > > > ...
> > > > > > > > / Trim skb to allocated size. User is expected to provide b=
uffer as
> > > > > > > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len cappe=
d at
> > > > > > > > * netlink_recvmsg())). dump will pack as many smaller messa=
ges as
> > > > > > > > * could fit within the allocated skb. skb is typically allo=
cated
> > > > > > > > * with larger space than required (could be as much as near=
 2x the
> > > > > > > > * requested size with align to next power of 2 approach). A=
llowing
> > > > > > > > * dump to use the excess space makes it difficult for a use=
r to have a
> > > > > > > > * reasonable static buffer based on the expected largest du=
mp of a
> > > > > > > > * single netdev. The outcome is MSG_TRUNC error.
> > > > > > > > */
> > > > > > > >
> > > > > > > > This is where I am currently but I have seen these bugs app=
ear throughout all my iterations including what's in the tree currently, if=
 you show me better alternatives that solve my problems, I'll gladly accept=
.
> > > > > > > > https://github.com/torvalds/linux/compare/master...jopamo:l=
inux:net-stable-upstream-v4
> > > > > > >
> > > > > > > I dont see a problem with "dump" as you seem to be suggesting=
. I asked
> > > > > > > earlier if it is possible that you can create some single ent=
ry - not
> > > > > > > 100 as shown above that will consume more than NLMSG_GOODSIZE=
? My
> > > > > > > limited knowledge is not helping me see such a scenario.
> > > > > >
> > > > > > Aha. I think there is a terminology mixup ;->
> > > > > >
> > > > > > "dump" (a very unfortunate use of that word in the netlink worl=
d ;->)
> > > > > >
> > > > > > is a very special word. So when you take a dump in this world y=
ou are
> > > > > > GETing a whole table. In this case all the gate actions.
> > > > > >
> > > > > > If i am not mistaken in your case this is not a dump - rather, =
you are
> > > > > > CREATing a single entry which is bigger than NLMSG_GOODSIZE as =
i
> > > > > > suspected. I dont believe iproute2 will allow you to do that.
> > > > > > What's happening then is that the generated netlink event notif=
ication
> > > > > > for that single entry is too big to fit in NLMSG_GOODSIZE.
> > > > > > Let me try to craft something for that...
> > > > > >
> > > > > > cheers,
> > > > > > jamal

