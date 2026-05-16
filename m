Return-Path: <stable+bounces-249019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uVMsHVyuCGq60wMAu9opvQ
	(envelope-from <stable+bounces-249019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:50:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D925955CFD1
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE9C300F179
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B26E3E6DED;
	Sat, 16 May 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcQel1TJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F52379991
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778953815; cv=pass; b=FDfh8LUmpz35fNWrT9oIsp7NlBC1oc+XfpMn37gL85HBD1hafwQvTNm2Y7mo4NrULXsvBeRPF6mBMwX212Vcx5stTP6kK5A/iDf30fQpsXvo/e8Dz6QPBBWnRKT7iyjr06RHCuCF0uIGjK3Rbtvq3v8dyhrsI8dgbAhIL1Dbdg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778953815; c=relaxed/simple;
	bh=bb3jfN2NC/V2zD360wOTV4RVGdXSCuQwNzx7PxY9NBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKvxvYbAXhqBkEbnhAlllf7ZSttod+ryRI2ubVqm0eVh87ead70hZ3pMCjKWsxJiNmGuLAHqNiRK6knFVXTZaW10BtgcOFas76gI7VzztWtM0mZYqyFUF14u3JKveKz5u2u8g+QSUTc+b9pL2CUdPa5qPHpX/4WA1+Bga9uj7vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcQel1TJ; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bcc2b199c17so119675166b.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778953812; cv=none;
        d=google.com; s=arc-20240605;
        b=lki7gK5sMulDUSSt+Ti7Ek4WhbQz1Td5lg4hb+N+0lnyKlNZkrF8lJ9mdXBqdq5DVS
         udmtNahEpgz3eWxRVaTs5KxGW8Jz0D6zfeo3PP6BNgathoW+AVJ5UL0LFoBZGMaj1o8W
         6sQjnxQX8Kc80NXBxqKruJFPFETMiVkI/8XWcVmmVM+90dPeosEcrwc6aEeSmOCSc5RJ
         fu4ufhSiJWhu7T5ScSWYT58E4sXia6FC1iUWzgURXnHCjkTdOR+SN7tbQW+Fm0fmyAP+
         yqXTwP4DrTa5m/doOlu4dV6kvti/5YYvxN7ppMvVrRe5FnQA/KCpV/zG59V9lgM4n48g
         AQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RgYePu8cI4pa48iwAoaqdJpOJOEYxs5lf2I9rBiO5Jc=;
        fh=0cT2fo8Twu+pd5zohjHv+ALbhtRL+A1dRMmvTaHU8v4=;
        b=D1C+DBZVMwJxE6AbT/q5SLWrML0ZjRtE97WF7Qh+bySXBtfkLW4BfHJywLZdtb+PQO
         jmu8wsehk2R0eHarvrHWs3GgRsrxuq79be3rE9qhAfk7XnBCWhCSB1pikxSDrM8xZIZt
         OujOmH6Eyzl5fr+TqMdZDUpZyKqQceQ+FHKvQAV4/J+bJB5RGVv021YhWtLas/E7rBpM
         6qFqL6AtWwoIYkWiSzZt/35jXf9chcMKRy58cDoi5zGB9SDHR8MieKh73/i4lem4s1Tw
         OC8ALFkR5UAQXhmG87IOantFVPJSDX03G8qJ7KTzrFX6kYHnyKxP9dfAe8/Ns+31IoEK
         ZoRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778953812; x=1779558612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgYePu8cI4pa48iwAoaqdJpOJOEYxs5lf2I9rBiO5Jc=;
        b=XcQel1TJQ7YY76k/iqfvfos49PPGB0wgRVO294aeZaRlW0H+B5GMD0/y2ah9yAoqog
         CcyXKkaF6/d2/ws0WVuZmkJSKVDfiuio8/svJgpe0WDvhZY4VGgiRSADJB7a0moHbjjv
         Ip3inYK0exNu/QnHg6nAcAGdYWVzx6+OcraWOOv/DoBZiu6YUzCI6dNtNfSHvYTdkueK
         jzOGe7IH6KS7AfsljXYbNMe3d5Ghn7pJSt/fMVRpzgGNqgOV98dDhRRHqZgfkMWfinVP
         VLCzBN5R/E2knhuDSbjxmAQ9cn3IGNlcteWML/sDFxGjsvoUKzIW+K3Ek978DzDOXaoi
         Zi5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778953812; x=1779558612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RgYePu8cI4pa48iwAoaqdJpOJOEYxs5lf2I9rBiO5Jc=;
        b=VfMB4wxyLbnSSCF6ZBwuQzmh46xw0awvGko8Qo+MfkyjTuWwbGlj1lf2NrU3hT1Vzr
         Su0Tsn0fOrwS3oDrglVD1hEtFCjc8z70Ge/N6stKZzwTSYfX/eUAh2G65CTKr+0AqvJB
         w0fBuIZwwVA96fFmM3rZgk8ph8SMmxE+/f2wWu3QoiXyc+afZSQemhBsARovjeLCsiV1
         zuOnSUaLHUzXeCFIoSIknlEfh9yYCJZAXBeSPZyX34ZQ6fPoQSUEx3U40w+k5B+fcWXN
         e5cYiMpLtD4q01iOpg/5T9OlWI/UAaJ0wC6hd7oDcHbD/Ufg6qGYUL5hHuUsecmlP4Ei
         z9cw==
X-Forwarded-Encrypted: i=1; AFNElJ+2j1ZCocRyqCRZZlBXkM1cCoWpcPN0VTq6nrGBI3PF2i+Pz13YYm8MJyEMMn7OpMkk48pagps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQXwZRPT2gl+fgTZU1JGmiZBfcIv1UObz9jkwW33pXCvjVORW
	1Tz7oDnLDVwR2b7xSsltGpvzxqvNeQ7mYKvjeWlWl0HSLZkW9+yOu4JQy7KVVHxXRrEQb2+KEiW
	0VQTgRLBSBURhe5GN1C5Ai0Wh5EIq37k=
X-Gm-Gg: Acq92OFY5MwSeJOxN0kOS+6J2UlxtV9jDidgGVLGqb0BUwwh+vrml4ShGF5fBgVvsRd
	ppUsbDh542RKyK6ddqKlrRySvqlW5g/g4g7UY30DTlPy7mfrySU88BNwyWOluNmSkxE9kiCyFcZ
	ocLxDCepC3sSLclBGXTnE9pjgGsJOMqmLPkPTqitL1ABnIKSnzUsKR+jruyTffjQnoiIyBF196c
	u/3MNjpBaCoS21m/Wr4asf3nsy1AP4DEkjSUWxDttis5Je4kYRSqYhHjBguEe2PFwqLJfWYbpST
	gk+wsUOqqSlkLUXxfA==
X-Received: by 2002:a17:907:a317:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bd5179305eamr483428566b.24.1778953811413; Sat, 16 May 2026
 10:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516162825.1480113-1-rollkingzzc@gmail.com> <CAM0EoMmrn4gJ8KNu4kDpEP3+GWR1+jtJgbxMDgO_ZmyA4e6qOA@mail.gmail.com>
In-Reply-To: <CAM0EoMmrn4gJ8KNu4kDpEP3+GWR1+jtJgbxMDgO_ZmyA4e6qOA@mail.gmail.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Sun, 17 May 2026 01:49:35 +0800
X-Gm-Features: AVHnY4JppdSJS1WufNsw47NSZtQlKCJAvs11MY7gSvk91z1FKBtNCedeI3YwvFA
Message-ID: <CAOPYjvacjz-mGTWgPVRzWu9Cx593mfLdot5vUCHh_W_5oBu4sA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: act_pedit: extend the writable skb range per key
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Zhang Cen <rollkingzzc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	zerocling0077@gmail.com, stable@vger.kernel.org, 
	"yimingqian591@gmail.com" <yimingqian591@gmail.com>, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D925955CFD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249019-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 1:38=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, May 16, 2026 at 12:28=E2=80=AFPM Zhang Cen <rollkingzzc@gmail.com=
> wrote:
> >
> > tcf_pedit_act() builds a rough writable prefix from tcfp_off_max_hint
> > before the action mutates any packet bytes.
> >
> > Since 6c02568fd1ae, TCP and UDP keys recompute their L4 base from the
> > current L3 header inside the key loop. An earlier key can therefore
> > change a later header-relative base and make the final store land
> > outside the initially ensured prefix, where it can fall back to
> > skb_store_bits() on skb frags.
> >
> > Keep the initial estimate as a fast path, but grow the ensured writable
> > range from each key's final computed write offset before loading or
> > storing the edited word.
> >
> > Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 offs=
et")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Han Guidong <2045gemini@gmail.com>
> > Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>
> Please dont report or post such patches in the public next time.
> Follow the procedure outlined here:
> https://docs.kernel.org/process/security-bugs.html
> I have removed the public mailing lists from this response.
>
> This issue has been under discussion for the last two days based on
> two other patches. Those patches are better than what you posted. We
> will make sure you get added to as reporters of this bug.
> Will you be willing to test the final solution?

Hi Jamal,

Thank you for the guidance and for including us as reporters. We would
be glad to test the final solution.

Apologies for posting this publicly and for any inconvenience caused.
We will strictly follow the proper security procedure in the future.

Thanks.

>
> cheers,
> jamal
>
> > ---
> > While researching recent page cache bugs, we discovered this bug. We co=
nfirmed it allows overwriting the page cache of read-only files via splice(=
). We haven't attempted to write an exploit, but the corruption primitive i=
s verified. PoC available upon request. Recommend fixing ASAP.
> > ---
> >  net/sched/act_pedit.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index bc20f08a27890..58a8eae6d43e7 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -398,11 +398,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >
> >         parms =3D rcu_dereference_bh(p->parms);
> >
> > -       max_offset =3D (skb_transport_header_was_set(skb) ?
> > -                     skb_transport_offset(skb) :
> > -                     skb_network_offset(skb)) +
> > -                    parms->tcfp_off_max_hint;
> > -       if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > +       max_offset =3D min_t(u32, skb->len,
> > +                          (skb_transport_header_was_set(skb) ?
> > +                           skb_transport_offset(skb) :
> > +                           skb_network_offset(skb)) +
> > +                          parms->tcfp_off_max_hint);
> > +       if (skb_ensure_writable(skb, max_offset))
> >                 goto done;
> >
> >         tcf_lastuse_update(&p->tcf_tm);
> > @@ -414,8 +415,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> >                 int offset =3D tkey->off;
> >                 int hoffset =3D 0;
> > +               int write_offset;
> >                 u32 *ptr, hdata;
> > -               u32 val;
> > +               u32 val, write_end;
> >                 int rc;
> >
> >                 if (tkey_ex) {
> > @@ -451,12 +453,26 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buf=
f *skb,
> >                         }
> >                 }
> >
> > -               if (!offset_valid(skb, hoffset + offset)) {
> > -                       pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n", hoffset + offset);
> > +               write_offset =3D hoffset + offset;
> > +               if (!offset_valid(skb, write_offset)) {
> > +                       pr_info_ratelimited("tc action pedit offset %d =
out of bounds\n",
> > +                                           write_offset);
> >                         goto bad;
> >                 }
> >
> > -               ptr =3D skb_header_pointer(skb, hoffset + offset,
> > +               /* Earlier edits can change later header-relative offse=
ts, so
> > +                * grow the writable window from the final per-key stor=
e.
> > +                */
> > +               if (write_offset >=3D 0) {
> > +                       write_end =3D (u32)write_offset + sizeof(hdata)=
;
> > +                       if (write_end > max_offset) {
> > +                               max_offset =3D min_t(u32, skb->len, wri=
te_end);
> > +                               if (skb_ensure_writable(skb, max_offset=
))
> > +                                       goto bad;
> > +                       }
> > +               }
> > +
> > +               ptr =3D skb_header_pointer(skb, write_offset,
> >                                          sizeof(hdata), &hdata);
> >                 if (!ptr)
> >                         goto bad;
> > @@ -475,7 +491,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> >
> >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> >                 if (ptr =3D=3D &hdata)
> > -                       skb_store_bits(skb, hoffset + offset, ptr, 4);
> > +                       skb_store_bits(skb, write_offset, ptr, sizeof(h=
data));
> >         }
> >
> >         goto done;
> > --
> > 2.43.0
> >

