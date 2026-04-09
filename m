Return-Path: <stable+bounces-235516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LC+Etcx2GmqZggAu9opvQ
	(envelope-from <stable+bounces-235516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:10:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74663D0710
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90395301C12E
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 23:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E439EF20;
	Thu,  9 Apr 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrDz3CdY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDF390223
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775776208; cv=pass; b=UgtT8u7vvfLUwV/JhNN79IhViV+loCV3fkiT3WZGUi7nfHElZW4dbxr96P0PbiNGpgSf5t0rde9udAc74HES0jE9xnXfVLwusO2CDuIsozBOfOR01yDEdAXy7SPGz4dLyKuk/A24tWjammihtH73B0dRPR4lvlTr/o3M7tDWTaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775776208; c=relaxed/simple;
	bh=hnqIVK9AmZg4pLfPqp1hiR8+DY2eWZrisJhjbUazIH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj3U4tNOIkL8GzqhgMqPWi3oTKxAfgYc8xxw3xypCM8xV5kQ5Q/OoUYbUU6vP9EvzTz+1zWop0lSOHsADudsbmAwoPZ6TrFK5t9yQXCYAU9Sjv4TNNVt4iRBI9uP6+XI2Grglqg2n3ex+55d8+rNh4GYSUjHYR8Fyzg0BvC5Qos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrDz3CdY; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so941367f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 16:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775776205; cv=none;
        d=google.com; s=arc-20240605;
        b=kOYH/EIhSDnjEGhWnxa7xj8t0TfWRMzhb1xSYssKo7tdE+8x4/q8V3pTUBlhf/Do8O
         pq7Fsu+FdduTU8PVfxMD8zZvz5aey65hbGmKGFkgZhvsy73DAjmDzpY4vTKqgLHzJHVr
         zY/WMfdUEK+jOLWziKtLnivNDGwqxZO452lAuiNzS3Rva+Ap5re7eXNu47m32VSyBGvv
         3tmsBGA3j/ovemsP1Y2g9p6H2fKkE0rIxppKPsYr71GaFKkSGu/D9Ae3up38hpCPMwt7
         bg6rXG5Z4pqYd5JdxQW281hd1wqvds7VabzdkEIHx4UWmi949FcAhCj2IlkLA2evsP8V
         H5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0720UCU3sQFjdaGRxAYeJgM+ub10KIdf1BhWBleziQ=;
        fh=lqnijj996HpCtd48O7gliQw1dzwTrdoPblK98PfcT+o=;
        b=QTXvZxg87Icl4Zp/A6Qhgjs2pLaiaG534h4XsNyUVAkNiMlyO1w4a1jQo1t5vrub0L
         u38ToZkS8NKFRAK94o59zhtXO3GRaZrVNc/cQtVbIBg/sKV5IQgNBtOmcC2mexd1qCXC
         hfLJgUlkLo+qK0ABUn3HeSVSiaEjMTu6DQrs41L4i3+R3q+n8sE0x5IqT+G6zAcJxrNm
         gIC16sFkh29ni1DaoxDsAkpLvmJU7cxorg64iJay4doW0kKT/JnSjv5coRpviF8WY37k
         NenKYZbIB8syXZCgTdSKjKtelwmgIJJflM6ZnPBIWdtNMYizGp6kFLTjRmplYO67klli
         n/Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775776205; x=1776381005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0720UCU3sQFjdaGRxAYeJgM+ub10KIdf1BhWBleziQ=;
        b=jrDz3CdYmFRT934nCxZI6OsELctFHzOm4dDTOZ1LQ/ALD4AqjCJ/jWxs84N4Ylirgu
         KGf/tqmbS8Bklr8JYcwaRqLOx2OHl6301or9UharTeqTbCMRiKHY6tnya5epMM7iLSat
         kRygfffxvCrrv8yQ2hx/+ZEeUC7f42X7P3N4lBXbx70AW2JNY4+z5eSKaJzbhqPrn/97
         EF8C0k6R/YQG/Y/uMBdhuYQg/DsGyfIuH0FA8L8w6tu60DjOdHdUFE7OOprzbqKJJi0W
         EOGCPZSV/p3SrYw8My36nzXZ9Z86io9+83yVCN6YSzVJBgD3VpPdRR5KwJI2L15XqVEb
         VDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775776205; x=1776381005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0720UCU3sQFjdaGRxAYeJgM+ub10KIdf1BhWBleziQ=;
        b=aVBauDZZIM7ezgZhhYW7pkMG1IoomdxmvlsnLUmuDMFEHVWCSJ5B4qnIx5bF+u15gF
         pbnzbWHO57uDiDTtUcfHBhwCud3BQPzmb3xbZPYhcPtJv1OcsJpAh7OVyupeEowkmUdP
         GzFpbbKJuDIieGQf1dlYBe86EZpblU+sLgV0Rn+9UQPqbza/5GPac5P8OZeQj88KHoSH
         jhYtG8c/HFdgoqaEljfp9JqrDg02sNs7OqVbZBdYZZJrbeofmg3K0/PNtlX8PfaQ0CQv
         yToOugHFbWomq5+AjdLhZWOiRKm57/AeBojRf3E9hjEZy+SXgFvP2q9HJgYNbuX8s5+C
         ZP7A==
X-Forwarded-Encrypted: i=1; AJvYcCWt08DFkp9bewI0L61DLqH9TMlFnu9xESi0xqTjExbCqqUHWVk3YGbSeHHulEvZi130ZbQswAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8n6J+EWNEvOXcnBDcNieBxqvyyO4SUaJgzHQ/vlnWPMonWKLA
	TbAL46+TX1vM4a5d7hoR+nFyJ1DDV85Ah3CkQyWoxumO4quPwv7V7gVAQ3Oy9nfVglIaU1Dd4yw
	t/b1xka1qAWYil7CmGrnW0fA7YZUEZQg=
X-Gm-Gg: AeBDievvO1IThVt2jOATicBv6eZiOHCgE8Fk9VkDLlVY1Ov9oaW9UKlGHTRfbwnvEuQ
	1PKekyZ5DSPzBXPWuZ0FZHh34EhRyuak/KYMUudFAkimLt7xuhJz7IqGn5xlk++dpssXh3p9Oe5
	LTXRERJh5nTFh6FbsGq5iAkU7ebNgzeWq9THSf0EIQ5HFZk6UjZ8Pyf4QlLPZA0xT6GjRzxVWZS
	EsW//IKD9crS8ZXdjE/V3rexVPE1nu9G0wDA9LDzzApo1fn0L9r0cSeNuT7UIg/KbnYHdn86O0v
	6YjyEreAAdkZPHJS
X-Received: by 2002:a05:6000:2211:b0:43c:f247:4792 with SMTP id
 ffacd0b85a97d-43d642702a4mr1194138f8f.12.1775776205019; Thu, 09 Apr 2026
 16:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
In-Reply-To: <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 9 Apr 2026 16:09:53 -0700
X-Gm-Features: AQROBzAWY9HD1HeNgkxoBCmsk_3-haNIvT52DUzlw8juQUIk6-SVKZJCxSZwekw
Message-ID: <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235516-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ddn.com:email,bsbernd.com:email]
X-Rspamd-Queue-Id: B74663D0710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 10/21/25 23:33, Bernd Schubert wrote:
> > Do not merge yet, the current series has not been tested yet.
>
> I'm glad that that I was hesitating to apply it, the DDN branch had it
> for ages and this patch actually introduced a possible fc->num_waiting
> issue, because fc->uring->queue_refs might go down to 0 though
> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> flush the queues without another addition.
>

Hi Bernd and Jian,

For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
from fuse_uring_cancel" email was never delivered to my inbox, so I am
just going to write my reply to that patch here instead, hope that's
ok.

Just to summarize, the race is that during unmount, fuse_abort() ->
fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
fuse_uring_entry_teardown() gets run but there may still be sqes that
are being registered, which results in new ents that are created (and
leaked) after the teardown logic has finished and the queues are
stopped/dead. The async teardown work (fuse_uring_async_stop_queues())
never gets scheduled because at the time of teardown, queue->refs is 0
as those sqes have not fully created the ents and grabbed refs yet.
fuse_uring_destruct() runs during unmount, but this doesn't clean up
the created ents because those registered ents got put on the
ent_in_userspace list which fuse_uring_destruct() doesn't go through
to free, resulting in those ents being leaked.

The root cause of the race is that ents are being registered even when
the queue is already stopped/dead. I think if we at registration time
check the queue state before calling fuse_uring_prepare_cancel(), we
eliminate the race altogether. If we see that the abort path has
already triggered (eg queue->stopped =3D=3D true), we manually free the
ent and return an error instead of adding it to a list, eg

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d88a0c05434a..351c19150aae 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -969,7 +969,7 @@ static bool is_ring_ready(struct fuse_ring *ring,
int current_qid)
 /*
  * fuse_uring_req_fetch command handling
  */
-static void fuse_uring_do_register(struct fuse_ring_ent *ent,
+static int fuse_uring_do_register(struct fuse_ring_ent *ent,
                                   struct io_uring_cmd *cmd,
                                   unsigned int issue_flags)
 {
@@ -978,6 +978,16 @@ static void fuse_uring_do_register(struct
fuse_ring_ent *ent,
        struct fuse_conn *fc =3D ring->fc;
        struct fuse_iqueue *fiq =3D &fc->iq;

+       spin_lock(&queue->lock);
+       /* abort teardown path is running or has run */
+       if (queue->stopped) {
+               spin_unlock(&queue->lock);
+               atomic_dec(&ring->queue_refs);
+               kfree(ent);
+               return -ECONNABORTED;
+       }
+       spin_unlock(&queue->lock);
+
        fuse_uring_prepare_cancel(cmd, issue_flags, ent);

        spin_lock(&queue->lock);
@@ -994,6 +1004,7 @@ static void fuse_uring_do_register(struct
fuse_ring_ent *ent,
                        wake_up_all(&fc->blocked_waitq);
                }
        }
+       return 0;
 }

 /*
@@ -1109,9 +1120,7 @@ static int fuse_uring_register(struct io_uring_cmd *c=
md,
        if (IS_ERR(ent))
                return PTR_ERR(ent);

-       fuse_uring_do_register(ent, cmd, issue_flags);
-
-       return 0;
+       return fuse_uring_do_register(ent, cmd, issue_flags);
 }

There's the scenario where the abort path's "queue->stopped =3D true"
gets set right between when we drop the queue lock and before we call
fuse_uring_prepare_cancel(), but the fuse_uring_create_ring_ent()
logic that was called before fuse_uring_do_register() has already
grabbed the ref on ring->queue_refs, which means in the abort path,
the async teardown (fuse_uring_async_stop_queues()) work is guaranteed
to run and clean up / free the entry.

Thanks,
Joanne

> Thanks,
> Bernd
>
> > The race is only easily reproducible with additional patches that
> > pin pages during FUSE_IO_URING_CMD_REGISTER - slows it down and then
> > xfstest's generic/001 triggers it reliably. However, I need to update
> > these pin patches for linux master.
> >
> > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> > Bernd Schubert (1):
> >       fuse: Move ring queues_refs decrement
> >
> > Jian Huang Li (1):
> >       fs/fuse: fix potential memory leak from fuse_uring_cancel
> >
> >  fs/fuse/dev_uring.c | 33 ++++++++++++++-------------------
> >  1 file changed, 14 insertions(+), 19 deletions(-)
> > ---
> > base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> > change-id: 20251021-io-uring-fixes-cancel-mem-leak-820642677c37
> >
> > Best regards,
>

