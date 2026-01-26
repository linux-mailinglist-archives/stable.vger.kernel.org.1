Return-Path: <stable+bounces-211534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIegKI0rd2nacwEAu9opvQ
	(envelope-from <stable+bounces-211534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:53:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D485A57
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84143300E5CF
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C43090C5;
	Mon, 26 Jan 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="mvwkY5OJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EA61E5B73;
	Mon, 26 Jan 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417605; cv=none; b=W34tMzrt8riDDSp74uzB8wOKmDAXtDOkQveSrjlyWv/wApgeuogyDOTWfurLEp62L4pAU6A27hFCzdrVWU+UaqFRdSn6LvydeTW+q8bsNOgG3zPq9+BSsAPAqfDfMBWiQ+fZeQRozyWICVyE/Iww109rDFBnT/1vXf4zuafm0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417605; c=relaxed/simple;
	bh=BJZV3Cw0Vi7MkeA/1O9xXI98G1YadhiApczo4SXoCWY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeXjHVJ+D8ByTk8RXAsJGflyOyiZbDXhcp0PQ1hv3p7n+gwKi1VsfBTiW1ku7CA7yzBPdvZKmsBwRQPyol5prPqdMZ+9pyDp4xU53aQn5tspnNOsmqtEyBkdH4y2kMQdMmgvDeFoANHSsMcfPojjjatD6RpOouAPjJgVa05inPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=mvwkY5OJ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1769417594; x=1769676794;
	bh=BJZV3Cw0Vi7MkeA/1O9xXI98G1YadhiApczo4SXoCWY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mvwkY5OJxXeFNzNr7ahxsOnntKz6G7CbV0YYAj4hQHpemmWFSwXQV9f6yfiDmexZN
	 eycbtoZBeGj6BF+kHbqD4ELjBhyQij2RK0su6nP5jlOledkd1ON/qq9ClQFQQ9A16O
	 2xbhyPrj5LKIrhjW/Ph3od2Fi4r7LfKObknDG7soGsyMlX7Oc11iySco7fWXPKeCgT
	 EIfv5LiuDNKgKBERdXE7AE1yVJJc84NIqHIIRI0mMZYedgvbcYIvSXX2ruRTnh+Pgs
	 GhHkoxPF/edOnFsU+8DEwOb2YJjrpk7lbLH0riglIQYyTgQXQ3CyGg3yY/Z/put1SE
	 k6BCsuvUrpdAw==
Date: Mon, 26 Jan 2026 08:53:10 +0000
To: Victor Nogueira <victor@mojatatu.com>
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
Message-ID: <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
In-Reply-To: <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org> <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: c1fd98711753fdf12f01526c362f688a5aa969b6
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-211534-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 314D485A57
X-Rspamd-Action: no action

Should REPLACE with an explicit entry list that yields 0 entries return -EI=
NVAL or should it be treated the same as omitting TCA_GATE_ENTRY_LIST and k=
eeping the old schedule?

thanks,
Paul





On Wednesday, January 21st, 2026 at 3:49 PM, Victor Nogueira <victor@mojata=
tu.com> wrote:

>=20
>=20
> On 21/01/2026 16:44, Victor Nogueira wrote:
>=20
> > On 21/01/2026 10:20, Paul Moses wrote:
> >=20
> > > Reject empty schedules (num_entries =3D=3D 0) so next_entry is always
> > > valid and
> > > RCU readers/timer logic never walk an empty list. taprio enforces the
> > > same
> > > constraint on schedules (sch_taprio.c, commit 09dbdf28f9f9fa).
> > >=20
> > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action"=
)
> > > Signed-off-by: Paul Moses p@1g4.org
> > > Cc: stable@vger.kernel.org
> > > ---
> > > net/sched/act_gate.c | 6 ++++++
> > > 1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > > index 48ff378bb051a..e4134b9a4a314 100644
> > > --- a/net/sched/act_gate.c
> > > +++ b/net/sched/act_gate.c
> > > @@ -509,6 +509,12 @@ static int tcf_gate_init(struct net *net, struct
> > > nlattr *nla,
> > > cycletime_ext =3D nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
> > > p->tcfg_cycletime_ext =3D cycletime_ext;
> > > + if (p->num_entries =3D=3D 0) {
> > > + NL_SET_ERR_MSG(extack, "The entry list is empty");
> > > + err =3D -EINVAL;
> > > + goto release_mem;
> > > + }
> >=20
> > It would be simpler to check this in parse_gate_list.
> > That way you could return -EINVAL there directly
> > in case 0 entries were passed.
>=20
>=20
> On second thought, I believe it would be better
> to check whether parse_gate_list's return is 0
> and the op is a create. Something like:
>=20
> err =3D parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
> ...
> if (!err && ret =3D=3D ACT_P_CREATED) {
> NL_SET_ERR_MSG(extack, "The entry list is empty");
> err =3D -EINVAL;
> goto release_mem;
> }
>=20
> so that you don't need to add new arguments to
> parse_gate_list.
>=20
> cheers,
> Victor

