Return-Path: <stable+bounces-237994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM7RL/Hd3mkEKQAAu9opvQ
	(envelope-from <stable+bounces-237994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA533FF559
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A65FA3044098
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 00:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AF0276050;
	Wed, 15 Apr 2026 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnob8yEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06425487C
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213484; cv=pass; b=s1hEHDDYMRo4HPFJoWlOq4afL7d7LUBACSWBN3HYSe/bf/zFLvOSTcgxD9xnLOAA6SyKBmdPl6+gPnLqDIRY3KFVlTbYR6+sxSNKtIDKCGaIyzd+wd+H9HFcmihreVp17FjDwJ+JsIOzOu636I5yOKefDKPtY7Ll2GYLVS7+bgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213484; c=relaxed/simple;
	bh=p6JrTUIr2E1LuZ95wwFshHfkLO8o0ThY5zWYeFuf9Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMhA5z1LL3V1YY6QxT+f6FqzGb0ReYV2aiQJae+SPDCcOLT7emPws82KeM/y/DWLo4yss1hcnLxDn2uaQe6yD8imCzlz4aZTOnQroHfPqUl87RgQE2Pl2OuSN0hl1xPxUgIFaALg287VrO7bRsmxuej0iuzS5ehdy/sET/Sh9Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnob8yEd; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d72875729so2005655f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:38:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776213480; cv=none;
        d=google.com; s=arc-20240605;
        b=EniUV/aNg9+/z+ZtROlHwxYHBdKAVUfUBgXxILfyRHk4QZLXhnhS0IvkBn+px0eXtI
         pU7vSATgZqKzZe6cK5R547ACjlKsuMNFUcHwBgA+bw2rwY7xVnzB45ZE8JNXhvL+6l4t
         uYRvR8t6hBMjBYtJc9f1+JoH0Jkbgmp59hBs5tUH9E8TKnp+kQTWRgO25JSHyo/cJ31D
         EaOBIqDqdjZMKVloUaaar60gq4Aqrf3WxTPL7zLMdClaGBLSlkkGBBy79JM5tOAXfDe6
         u/gp3NQXL9iUjAu2HFSw/LC1jauV2KN1dV4NndWkZTPe2kCiccRukRt308Dx4QtXpfOT
         2+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CR38Kupy2+VnJ7lVwX2A2ymaN+X2nMKHUlpRNC+LMcM=;
        fh=Ku8aL/Z5Z3pjbHsOyCg4iRpC9T9v5O3rA41tWX2WGqk=;
        b=DnWyrSPFCV+xblAH09fW73OhKlGNlW4LoHthBmvXH8xX00X+a2t+9Ryg8JjQn5NuVh
         ium/l6pEbgIcCISYpJobxjjeopQhLf8QzfE1awUZj1czX/iZn601VLdPcpAWZ9cBuUWS
         oXf8ig6jTDPitGBnh1agJ3ny+qw94BBP2GmZYcvBADRW51Wg2/PR2nkQhqY3REZ8h5uk
         yY1s/ltnT663K8xfypUHuGCKDtPjlbcUFupIRAMAp0cjbaMaHCR4JtXK2AUUj6GVtk9N
         +XxBDbmb/DedAe0jyFu5nCE7s3L/E68aN3ij20P1tqRPVEdT2uzTxqmExrfptNuuf7tl
         dIag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776213480; x=1776818280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CR38Kupy2+VnJ7lVwX2A2ymaN+X2nMKHUlpRNC+LMcM=;
        b=jnob8yEd1RHSzxYQJ0b4b8Y6ahcF5jCAtsLi1VPkuZK8lQ4ZelAGjlfGyKzAnxYIRc
         DmodX4Vx1cDMaueTeq9Mzzbm0e6Pndm9C2i58KhZ59MUavJpK1JlZg0K9k5JmITLdPOu
         JIgmLpJTr1mMQRS28ZTf0HPqKVITI1kv5/JSsizgPVHe7lHAsGoFR08jyBGkqpLeKu6s
         PZtVpjECptirPOT2ShUrBgTOkrn5M/CDfq1RrmJJBce7/lbmXQ9k/ZwtUOWMKKsYN0ud
         BGeTrMlCk+u6ejodc72W2u/LRKzrV+zucJF2GlHFckLI63UBVdVJ/UZ6mQ+1+P6H8adV
         zrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776213480; x=1776818280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CR38Kupy2+VnJ7lVwX2A2ymaN+X2nMKHUlpRNC+LMcM=;
        b=SuFthevput8Z/L7POl8uUVbJxhXcpkQhTn5xnFGDOxW1nqaNmWoVvO5R5QTZ13qXQ4
         H5DDYoGo8SBvFNf/VTqtlzuLa/3w12brNZbIsj69jPTZVW7H6/pBZFmIxqMmeUs2mK6L
         EB+LkyHhDFGT+Hb1zf1zRCZYQ+us5Kg2WILSE4lOaXBOQq5OVYCk4Uq09kj1JNCt3EBF
         n2xVS3M5fuU2q8rboaIPZCemkGHsmUuNkJcgPeVEud9fZKAcz0PMxpRTNcMFX2R9INhO
         t1JaEW+8OB7tHpe7741w7pyxX8caN2qB77/3SeG5DNYvVft3WmCxDH4yZEMk79vwW6He
         D7eQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/JJq+QeFg6jsEC7TcYbHDGCy6UGuO5BWr0y9GMxYoP7hj0KOwiapoIU4utpKOu08PShaDPq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/OmlQyOfYmom6VYkklB1I1R+xRV7Xp4Ru8trtgdaN6D67OuE
	EIcSTGIy1SByp9+m9yDCH/diKOvu4MaNEw+5bUuN9QPBSzY/oruBGsiXw3q41lPNHVQ7D3yGgb/
	hvvZNC5A8djctb9D1BHojtZvo92YzRPo=
X-Gm-Gg: AeBDietoOiAHcaVKfFVtMKpSccPlN+QxM4DRr+P2aiBGxv+EuYLqio11g3yRxYmVtd5
	LeMUBRRcZQo3yGYHS/DafgSUL1OFOj/pGKa1SZtd00SLC+Hk+3PFP3MWjrfbECD+fskEDrkwDZM
	Q99tnB204mAur3vS4DhJPBRCb4Cpek3uSCWmHkwBf26ku8XrE75THEGtIk0iU6HSjGWFb8TELuK
	cnUResnyEGRPwVw+8ItmD5zVbDpXHIJ7MiNkRwAIx3oWizo+FJweahf1xUYJa/+2aFPQHrvxv2b
	BlIBlwgULVgZM3wd
X-Received: by 2002:a05:6000:4283:b0:43e:a994:1aae with SMTP id
 ffacd0b85a97d-43ea9941b67mr2375702f8f.16.1776213480088; Tue, 14 Apr 2026
 17:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <3eabbc7b-010f-4d4c-9145-30d69fe1aa79@bsbernd.com> <CAJnrk1aoxGMGNZi+OwdoET6ahhGHp_7dw__=dmOWW+PMxnsj2w@mail.gmail.com>
 <adlyjDaxLZyHcSun@fedora> <CAJnrk1Yb2ABBKFK=KMaU+W10FNazt+h93P445i1USXcN2W45Xw@mail.gmail.com>
 <f27651af-e5c0-4c3e-8baa-fa2d7232cb4d@bsbernd.com> <CAJnrk1YPrPXN74fgesg1dbqJJsmjPOJ_My_mYMUevJfSrmrECg@mail.gmail.com>
 <33b4048c-e940-4cf4-80b4-88bc1adbd4a9@bsbernd.com> <CAJnrk1ZxijgYVTwzgX3LHoePtyOmOz-1y7swbgquT3_rxrLpvw@mail.gmail.com>
 <6b62e345-a4d4-4067-b3c4-f773c8fe3036@ddn.com>
In-Reply-To: <6b62e345-a4d4-4067-b3c4-f773c8fe3036@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Apr 2026 17:37:48 -0700
X-Gm-Features: AQROBzDxU2sSv47x3THhWqy57wXoY3NOl9qEMS-Sg8TpUrZ9lzvUb4ne2FW5c9w
Message-ID: <CAJnrk1Y_hYpr=1SkCuqRPtthurWKu67kaFtTisVyVZvdCewXCQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Horst Birthelmer <horst@birthelmer.de>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-237994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FA533FF559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 2:49=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 4/14/26 01:24, Joanne Koong wrote:
> > On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> >> On 4/13/26 17:56, Joanne Koong wrote:
> >>> On Sat, Apr 11, 2026 at 12:22=E2=80=AFPM Bernd Schubert <bernd@bsbern=
d.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/11/26 20:11, Joanne Koong wrote:
> >>>>> On Fri, Apr 10, 2026 at 3:08=E2=80=AFPM Horst Birthelmer <horst@bir=
thelmer.de> wrote:
> >>>>>>
> >>>>>> On Fri, Apr 10, 2026 at 02:24:08PM -0700, Joanne Koong wrote:
> >>>>>>> On Fri, Apr 10, 2026 at 4:26=E2=80=AFAM Bernd Schubert <bernd@bsb=
ernd.com> wrote:
> >>>>>>>>
> >>>>>>> Hi Bernd,
> >>>>>>>
> >>>>>>>> Hi Joanne,
> >>>>>>>>
> >>>>>>>> On 4/10/26 01:09, Joanne Koong wrote:
> >>>>>>>>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bs=
bernd.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>>>>>>>> Do not merge yet, the current series has not been tested yet.
> >>>>>>>>>>
> >>>>>>>>>> I'm glad that that I was hesitating to apply it, the DDN branc=
h had it
> >>>>>>>>>> for ages and this patch actually introduced a possible fc->num=
_waiting
> >>>>>>>>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>>>>>>>> fuse_uring_cancel() and then fuse_uring_abort() would never st=
op and
> >>>>>>>>>> flush the queues without another addition.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Hi Bernd and Jian,
> >>>>>>>>>
> >>>>>>>>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory =
leak
> >>>>>>>>> from fuse_uring_cancel" email was never delivered to my inbox, =
so I am
> >>>>>>>>> just going to write my reply to that patch here instead, hope t=
hat's
> >>>>>>>>> ok.
> >>>>>>>>>
> >>>>>>>>> Just to summarize, the race is that during unmount, fuse_abort(=
) ->
> >>>>>>>>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> .=
.. ->
> >>>>>>>>> fuse_uring_entry_teardown() gets run but there may still be sqe=
s that
> >>>>>>>>> are being registered, which results in new ents that are create=
d (and
> >>>>>>>>> leaked) after the teardown logic has finished and the queues ar=
e
> >>>>>>>>> stopped/dead. The async teardown work (fuse_uring_async_stop_qu=
eues())
> >>>>>>>>> never gets scheduled because at the time of teardown, queue->re=
fs is 0
> >>>>>>>>> as those sqes have not fully created the ents and grabbed refs =
yet.
> >>>>>>>>> fuse_uring_destruct() runs during unmount, but this doesn't cle=
an up
> >>>>>>>>> the created ents because those registered ents got put on the
> >>>>>>>>> ent_in_userspace list which fuse_uring_destruct() doesn't go th=
rough
> >>>>>>>>> to free, resulting in those ents being leaked.
> >>>>>>>>>
> >>>>>>>>> The root cause of the race is that ents are being registered ev=
en when
> >>>>>>>>> the queue is already stopped/dead. I think if we at registratio=
n time
> >>>>>>>>> check the queue state before calling fuse_uring_prepare_cancel(=
), we
> >>>>>>>>> eliminate the race altogether. If we see that the abort path ha=
s
> >>>>>>>>> already triggered (eg queue->stopped =3D=3D true), we manually =
free the
> >>>>>>>>> ent and return an error instead of adding it to a list, eg
> >>>>>>>>>
> >>>>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >>>>>>>>> index d88a0c05434a..351c19150aae 100644
> >>>>>>>>> --- a/fs/fuse/dev_uring.c
> >>>>>>>>> +++ b/fs/fuse/dev_uring.c
> >>>>>>>>> @@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring =
*ring,
> >>>>>>>>> int current_qid)
> >>>>>>>>>  /*
> >>>>>>>>>   * fuse_uring_req_fetch command handling
> >>>>>>>>>   */
> >>>>>>>>> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>>>>>> +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> >>>>>>>>>                                    struct io_uring_cmd *cmd,
> >>>>>>>>>                                    unsigned int issue_flags)
> >>>>>>>>>  {
> >>>>>>>>> @@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
> >>>>>>>>> fuse_ring_ent *ent,
> >>>>>>>>>         struct fuse_conn *fc =3D ring->fc;
> >>>>>>>>>         struct fuse_iqueue *fiq =3D &fc->iq;
> >>>>>>>>>
> >>>>>>>>> +       spin_lock(&queue->lock);
> >>>>>>>>> +       /* abort teardown path is running or has run */
> >>>>>>>>> +       if (queue->stopped) {
> >>>>>>>>> +               spin_unlock(&queue->lock);
> >>>>>>>>> +               atomic_dec(&ring->queue_refs);
> >>>>>>>>> +               kfree(ent);
> >>>>>>>>> +               return -ECONNABORTED;
> >>>>>>>>> +       }
> >>>>>>>>> +       spin_unlock(&queue->lock);
> >>>>>>>>> +
> >>>>>>>>>         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >>>>>>>>>
> >>>>>>>>>         spin_lock(&queue->lock);
> >>>>>>>>> @@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
> >>>>>>>>> fuse_ring_ent *ent,
> >>>>>>>>>                         wake_up_all(&fc->blocked_waitq);
> >>>>>>>>>                 }
> >>>>>>>>>         }
> >>>>>>>>> +       return 0;
> >>>>>>>>>  }
> >>>>>>>>>
> >>>>>>>>>  /*
> >>>>>>>>> @@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_=
uring_cmd *cmd,
> >>>>>>>>>         if (IS_ERR(ent))
> >>>>>>>>>                 return PTR_ERR(ent);
> >>>>>>>>>
> >>>>>>>>> -       fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>>>>>> -
> >>>>>>>>> -       return 0;
> >>>>>>>>> +       return fuse_uring_do_register(ent, cmd, issue_flags);
> >>>>>>>>>  }
> >>>>>>>>>
> >>>>>>>>> There's the scenario where the abort path's "queue->stopped =3D=
 true"
> >>>>>>>>> gets set right between when we drop the queue lock and before w=
e call
> >>>>>>>>> fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent=
()
> >>>>>>>>> logic that was called before fuse_uring_do_register() has alrea=
dy
> >>>>>>>>> grabbed the ref on ring->queue_refs, which means in the abort p=
ath,
> >>>>>>>>> the async teardown (fuse_uring_async_stop_queues()) work is gua=
ranteed
> >>>>>>>>> to run and clean up / free the entry.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't think your changes are needed, it should be handled by
> >>>>>>>> IO_URING_F_CANCEL -> fuse_uring_cancel(). That is exactly where =
the
> >>>>>>>> initial leak was - these commands came after abort and
> >>>>>>>> fuse_uring_cancel() in linux upstream then puts the entries onto=
 the
> >>>>>>>> &queue->ent_in_userspace list.
> >>>>>>>
> >>>>>>> I think there are still races if we handle it in fuse_uring_cance=
l()
> >>>>>>> that still leak the ent, eg even with the fuse_uring_abort()
> >>>>>>> queue_refs gating taken out in the original (jian's) patch:
> >>>>>>> * thread A: fuse_uring_register() ->fuse_uring_create_ring_ent() =
->
> >>>>>>> kzalloc, sets up the entry but hasn't called
> >>>>>>> atomic_inc(&ring->queue_refs) yet
> >>>>>>>   concurrently on another thread, thread B: fuse_uring_cancel()
> >>>>>>> ->fuse_uring_entry_teardown() ->
> >>>>>>> atomic_dec_return(&queue->ring->queue_refs) -> brings queue_refs =
down
> >>>>>>> to 0
> >>>>>>>   At this instant, queue_Refs =3D=3D 0. fuse_uring_stop_queues() =
->
> >>>>>>> teardown entries (nothing left) -> checks "if
> >>>>>>> atomic_read(&ring->queue_refs) > 0", sees this is false, and skip=
s
> >>>>>>> scheduling any async teardown work
> >>>>>>>   thread A calls atomic_inc(&ring->queue_refs) for the new ent,
> >>>>>>> queue_refs is now 1, the ent is now placed on the ent_avail_queue=
, but
> >>>>>>> it's never torn down.
> >>>>>>>   the ent is leaked and there's also a hang now when we hit
> >>>>>>> fuse_uring_wait_stopped_queues() -> fuse_uring_wait_stopped_queue=
s()
> >>>>>>> where it sleeps and is never woken since it's waiting for queue r=
efs
> >>>>>>> to drop to 0
> >>>>>>>
> >>>>>>> imo, the change proposed in my last message is more robust and ha=
ndles
> >>>>>>> this case since it guarantees the async teardown worker will be
> >>>>>>> running (since it does the queue state check after the ent has gr=
abbed
> >>>>>>> the queue ref).
> >>>>>>
> >>>>>> Ok so you rely on the fact that fuse_abort_conn() will call
> >>>>>> fuse_uring_abort() and that sets queue->stopped.
> >>>>>> This could work, but I would still remove the check for
> >>>>>> queue_refs > 0 in fuse_uring_abort(), since it just complicates th=
ings
> >>>>>> for no real reason.
> >>>>>>
> >>>>>>>
> >>>>>>> btw, there's also another (separate) race, which neither of our
> >>>>>>> approaches solve lol. This is the situation where fuse_uring_canc=
el()
> >>>>>>> runs right after we call fuse_uring_prepare_cancel() in
> >>>>>>> fuse_uring_do_register() but before we have set the ent state to
> >>>>>>> FRRS_AVAILABLE. The ent gets leaked and continues to be used even
> >>>>>>> though it's canceled, which may lead to use-after-frees. This pro=
bably
> >>>>>>> requires a separate fix, I haven't had time to look much at it ye=
t.
> >>>>>>> Maybe Horst or Jian has looked at this?
> >>>>>>>
> >>>>>> Interesting scenario ... haven't seen that one so far.
> >>>>>
> >>>>> Looking at the io-uring code for how cancels are handled
> >>>>> (io_uring_try_cancel_uring_cmd()), I was wrong in my prevoius messa=
ge
> >>>>> about these two races. io-uring already serializes this for us, the
> >>>>> io-uring code unconditionally grabs the uring lock before invoking
> >>>>> file->f_op->uring_cmd() in the cancel path, which means there's no
> >>>>> interweaving between the fuse registration logic and the cancel log=
ic.
> >>>>>
> >>>>> But I still think the more robust/resilient fix for the memleak is =
to
> >>>>> do the preemptive checking at registration time. I think this fixes
> >>>>> races in the force unmount case between registration and abort that=
 is
> >>>>> unresolved with the original patch. With the original patch w/
> >>>>> fuse_uring_abort()'s queue_refs check removed, I think we can still
> >>>>> hit this:
> >>>>
> >>>> I need to go through the other messages, but I still do not see any
> >>>> registration time leak. At least not with the additional patch we ha=
ve
> >>>> here to tear down entries through IO_URING_F_CANCEL
> >>>
> >>> The issue is the hang, not the leak.
> >>>
> >>>>
> >>>>
> >>>> Sorry, besides also looking into ublk now (for main work), also in
> >>>> progress to fix an issue with reduced queues and also still on the
> >>>> libfuse part of sync-init....
> >>>>
> >>>>>
> >>>>> registration vs abort:
> >>>>>   - thread a: io_uring_enter -> register sqe ->
> >>>>> fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_r=
ef
> >>>>> yet
> >>>>>   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
> >>>>> fuse_uring_abort() -> fuse_uring_stop_queues() ->
> >>>>> fuse_uring_teardown_entries(), skips scheduling async teardown work
> >>>>> since queue_refs =3D=3D 0, returns
> >>>>>   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
> >>>>> fuse_uring_do_register() logic executes, ent is now marked cancelab=
le,
> >>>>> ent state is now available, ent is placed on available queue
> >>>>>   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now ru=
ns
> >>>>> and does a "wait_event(ring->stop_waitq,
> >>>>> atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the wa=
iter
> >>>>> never gets woken
> >>>>>
> >>>>> whereas if we check preemptively at registration time, we explicjtl=
y
> >>>>> free the ent and release the queue_ref. I think the preemptive chec=
k
> >>>>> needs to check ring->fc->connected though instead of queue->stopped=
,
> >>>>> because there's the race where abort and stop_queues() may have bee=
n
> >>>>> triggered before the register sqe path does queue creation. I'm hop=
ing
> >>>>> there's a better solution than having to grab the fc lock and check=
ing
> >>>>> fc->connected though, will try to look more at this next week.
> >>>>>
> >>>>> I think we can hit this hang on a ring creation vs abort race as we=
ll:
> >>>>> * thread a: fuse_uring_cmd() gets called, passes fc->aborted check =
(not set yet)
> >>>>> * thread b: abort is called, calls fuse_uring_abort(),
> >>>>> fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
> >>>>> * thread a: creates ring, creates queue, creates entry
> >>>>> - if thread a takes the queue_ref count before the rest of the abor=
t
> >>>>> logic, we end up with the same hang as the situation above.
> >>>>
> >>>> IO-uring sends IO_URING_F_CANCEL for every registred command. We nev=
er
> >>>> had a leak you describe. Upstream has a leak because it does not fre=
e
> >>>> 'queue->ent_in_userspace' in fuse_uring_destruct. I'm fine with the
> >>>> addition in fuse_uring_cancel() (although the just freeing the entri=
es
> >>>> in the list is much simpler and race free).
> >>>>
> >>>> Please let's not make it anymore complex.
> >>>
> >>> The issue is the hang, not the ent leak. What I'm trying to say is
> >>> that the original patch submitted fixes one issue (kfreeing the ents)
> >>> but doesn't fix the registration vs abort race, whereas the preemptiv=
e
> >>> registration check fixes the leaked ents and the race.
> >>>
> >>> With the original patch, the umount thread still gets stuck
> >>> permanently in TASK_UNINTERRUPTIBLE during the race. Even if the admi=
n
> >>> kills the daemon, the umount thread still holds the mount ref, which
> >>> means delayed_release -> fuse_uring_destruct() will never get called
> >>> and the entire ring gets leaked. If the original patch adds a
> >>> wake_up_all() when queue_refs hits 0 in teardown, then killing the
> >>> daemon does resolve it (as it'll wake up the umount thread), but the
> >>> force-unmount still blocks in TASK_UNINTERRUPTIBLE state until the
> >>> admin kills the server. The preemptive registration check is the more
> >>> robust fix imo.
> >>
> >> Hmm, I think you are right for normal umount, for daemon kill
> >> IO_URING_F_CANCEL handles it with the patch in this discussion - io-ur=
ing
> >> will send IO_URING_F_CANCEL in a loop until io_uring_cmd_done() done i=
s
> >> called.
> >> For plain umount I think it better to check for connection abort after
> >> ring->queue_refs was increased, i.e. up to the last moment when
> >> fuse_abort_conn() / fuse_wait_aborted() would wait. With the patch you
> >
> > I had mentioned this in my previous email, "the preemptive check needs
> > to check ring->fc->connected though instead of queue->stopped, because
> > there's the race where abort and stop_queues() may have been triggered
> > before the register sqe path does queue creation."
> >
> >> suggested, I think the connection could be aborted after the check and
> >> the ring entry might not be in any list yet, when fuse_uring_stop_queu=
es()
> >> gets called and queue stop would be a no-op.
> >
> > If the connection is aborted after the check and the ring ent isn't on
> > any list yet, I think that's fine. The async teardown worker is
> > already guaranteed to be scheduled (since the ring->fc->connected
> > check is done after the ent grabs the queue ref).
> >
> > The actual problem is that if the register sqe is the first sqe for
> > that queue and will trigger queue creation, then if the abort logic
> > runs first before the queue creation, it will skip all the logic in
> > fuse_uring_abort_end_requests() since "queue =3D
> > READ_ONCE(ring->queues[qid]);" is a null queue, and consequently
> > queue->stopped will never have been set to true.
> >
> >>
> >> How about this
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index 46812149bb2e..575b1042719c 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -1445,6 +1445,7 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *=
cmd,
> >>                            struct fuse_ring_queue *queue)
> >>  {
> >>         struct fuse_ring *ring =3D queue->ring;
> >> +       struct fuse_conn *fc =3D ring->fc;
> >>         struct fuse_ring_ent *ent;
> >>         size_t payload_size;
> >>         struct iovec iov[FUSE_URING_IOV_SEGS];
> >> @@ -1487,6 +1488,19 @@ fuse_uring_create_ring_ent(struct io_uring_cmd =
*cmd,
> >>         ent->payload =3D iov[1].iov_base;
> >>
> >>         atomic_inc(&ring->queue_refs);
> >> +
> >> +       spin_lock(&fc->lock);
> >> +       atomic_inc(&ring->queue_refs);
> >> +
> >> +       /* check if the disconnected while creating the entry */
> >> +       if (!fc->connected) {
> >> +               atomic_dec(&ring->queue_refs);
> >> +               err =3D -ENOTCONN;
> >> +               wake_up_all(&ring->stop_waitq);
> >> +       }
> >> +       spin_unlock(&fc->lock);
> >> +       if (err)
> >> +               goto error;
> >>         return ent;
> >>
> >
> > I don't think it matters if this is within
> > fuse_uring_create_ring_ent() instead of fuse_uring_do_register(). I
>
> Yeah, that doesn't matter, it just has to be after the increase of
> queue_refs. I probably missed the complete patch before, but I had
> only seen the change in fuse_uring_create(), which is before increase
> of queue_refs.
> Code changes in fuse_uring_create_ring_ent() are little bit smaller,
> as it already has the free of ring_ent. In the end I don't care and
> either way works.
>
> > put the logic inside of fuse_uring_do_register() because that seemed
> > logically cleaner to me (eg create_ent() is only responsible for ent
> > allocation/initialization logic, any race checks to halt rest of sqe
> > registration flow are outside that), though if you have a preference
> > to have it inside fuse_uring_create_ring_ent() that's fine by me. This
> > is waht I have locally:
> >
> > Subject: [PATCH] fuse/uring: fix abort races with ring creation and ent
> >  registration
> >
> > This fixes the following races:
> > registration vs. abort:
> >   - thread a: io_uring_enter -> register sqe ->
> > fuse_uring_create_ring_ent -> allocate ent but doesn't grab queue_ref
> > yet
> >   - thread b: fuse_conn_destroy() -> fuse_abort_conn() ->
> > fuse_uring_abort() -> fuse_uring_stop_queues() ->
> > fuse_uring_teardown_entries(), skips scheduling async teardown work
> > since queue_refs =3D=3D 0, returns
> >   - thread a: grabs the queue_ref, queue_ref is now 1, rest of
> > fuse_uring_do_register() logic executes, ent is now marked cancelable,
> > ent state is now available, ent is placed on available queue
> >   - thread b: fuse_abort_conn() returns, fuse_wait_aborted() now runs
> > and does a "wait_event(ring->stop_waitq,
> > atomic_read(&ring->queue_refs) =3D=3D 0);" which hangs since the waiter
> > never gets woken
> >
> > ring creation vs abort:
> > - thread a: fuse_uring_cmd() gets called, passes fc->aborted check (not
> >   set yet)
> > - thread b: abort is called, calls fuse_uring_abort(),
> > fuse_uring_abort() is a no-op since ring =3D=3D NULL right now
> > - thread a: creates ring, creates queue, creates entry
> > - if thread a takes the queue_ref count before the rest of the abort
> > logic, we end up with the same hang as the situation above.
> >
> > This additionally addresses the ent memleak in the registration vs
> > cancel race in [1].
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20251021-io-uring-fixes-cance=
l-mem-leak-v1-0-26b78b2c973c@ddn.com/
> > ---
> >  fs/fuse/dev_uring.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index f6b12aebb8bb..4bbc71755cb8 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -243,6 +243,10 @@ static struct fuse_ring *fuse_uring_create(struct
> > fuse_conn *fc)
> >         max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE=
_SIZE);
> >
> >         spin_lock(&fc->lock);
> > +       if (!fc->connected) {
> > +               spin_unlock(&fc->lock);
> > +               goto out_err;
> > +       }
>
> Strictly this isn't needed, but doesn't hurt either.

I think this is necessary else there is the race where this is the
first sqe that is being registered and it will trigger ring creation
but the ring hasn't been created yet when the abort logic runs. The
fuse_uring_abort() will see that the ring is NULL and skip the call to
fuse_uring_stop_queues() which will skip scheduling the async teardown
worker. Then when the sqe triggers ring creation and later ent
creation and grabs the queue_ref, it can lead to the same hang as the
registration vs. abort one where fuse_wait_aborted() sleeps forever
waiting in queue_refs =3D=3D 0, if the fuse_wait_aborted() logic runs
between the ent grabbing the queue ref and decrementing it in the if
(!fc->connected) logic.

>
> >         if (fc->ring) {
> >                 /* race, another thread created the ring in the meantim=
e */
> >                 spin_unlock(&fc->lock);
> > @@ -974,7 +978,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
> > int current_qid)
> >  /*
> >   * fuse_uring_req_fetch command handling
> >   */
> > -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> > +static int fuse_uring_do_register(struct fuse_ring_ent *ent,
> >                                    struct io_uring_cmd *cmd,
> >                                    unsigned int issue_flags)
> >  {
> > @@ -983,6 +987,16 @@ static void fuse_uring_do_register(struct
> > fuse_ring_ent *ent,
> >         struct fuse_conn *fc =3D ring->fc;
> >         struct fuse_iqueue *fiq =3D &fc->iq;
> >
> > +       spin_lock(&fc->lock);
> > +       /* abort teardown path is running or has run */
> > +       if (!fc->connected) {
> > +               spin_unlock(&fc->lock);
> > +               atomic_dec(&ring->queue_refs);
> > +               kfree(ent);
> > +               return -ECONNABORTED;
> > +       }
> > +       spin_unlock(&fc->lock);
> > +
> >         fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> >
> >         spin_lock(&queue->lock);
> > @@ -999,6 +1013,7 @@ static void fuse_uring_do_register(struct
> > fuse_ring_ent *ent,
> >                         wake_up_all(&fc->blocked_waitq);
> >                 }
> >         }
> > +       return 0;
> >  }
> >
> >  /*
> > @@ -1114,9 +1129,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >         if (IS_ERR(ent))
> >                 return PTR_ERR(ent);
> >
> > -       fuse_uring_do_register(ent, cmd, issue_flags);
> > -
> > -       return 0;
> > +       return fuse_uring_do_register(ent, cmd, issue_flags);
> >  }
> >
> >  /*
> > --
> > 2.52.0
> >
> > though I'll probably end up splitting this into two separate patches
> > when submitting. I don't think the wake_up_all(&ring->stop_waitq);
> > call is needed in the preemptive checking, as the async teardown work
> > will already take care of that.
>
> I have this in my mind
>
>
> core-A                                                  core-B
>
> fuse_uring_create_ring_ent()
>
>        ent->headers =3D headers->iov_base;
>        ent->payload =3D payload->iov_base;
>  }
>                                              fuse_conn_destroy()
>                                                 fuse_abort_conn()
>                                                   fuse_uring_abort() -> n=
o-op
>                                                 fuse_wait_aborted()
>
>         atomic_inc(&ring->queue_refs);
>                                                 fuse_uring_wait_stopped_q=
ueues()
>

Ah yeah that's a good point, the wakeup would be necessary for this
scenario. I think the atomic_dec() should be changed to

 if (atomic_dec_and_test(&ring->queue_refs))
      wake_up_all(&ring->stop_waitq);

Thanks,
Joanne
>
>
> Thanks,
> Bernd

