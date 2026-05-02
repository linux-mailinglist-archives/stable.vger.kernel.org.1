Return-Path: <stable+bounces-242590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBtJIBHI9Wm8OwIAu9opvQ
	(envelope-from <stable+bounces-242590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D44894B18FF
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91BCD3010C05
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC930AD0A;
	Sat,  2 May 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MP2O6I6U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1231DDC1D
	for <stable@vger.kernel.org>; Sat,  2 May 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777715214; cv=none; b=ebLPgCKeJZddxvD3+pYSInwBf8ovwY4GsD1qIeU0qCuXrcBNZ5FpeeAsRMAH4rQvxr6Nv5JZ6DWoy5mexVGngx4wFcJWmYjzHI5xt1YoZMZ7CZK6I4Wi/bUf10Yy5hgt2Vi6uYJxP0l3qlk1BlLHbs9OgUMBPOi5gOQir9hDK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777715214; c=relaxed/simple;
	bh=DPiNTEITt1TPBpjArvFJpFpEyHTx0vdtATFnbHgPgfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzEDVcPe3JjIXKWEr8UDu4Br7zkS+VpYJfWZQIitYXBIcj7C+eidzBHrsSePqkZ+X+ma6MfjMVwntD9wBnoKUiEG9wMIh4m9GJijNJqmYxVRYJhL7y6RYsIO6w8A9hgste9/oajP88ZtJaH+ksfLBe9LD7m7br89QrDv01uOp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MP2O6I6U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44a14580111so1277260f8f.0
        for <stable@vger.kernel.org>; Sat, 02 May 2026 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777715211; x=1778320011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezmD1eosO8J8L5bV2blwD7uKVAJ5uRnCIe2hKB1QaCg=;
        b=MP2O6I6UmkMu+yWeLeSdXoUwOAlMSjK4K9IympeZv4SCa8wB4CWZAwZoY/hzIZpP2U
         OMuXbB3PskdWK3w7ugNJ/lE/Yqj7fOqV4s3R26NigI8nW6srpOCBRv1eSMFHVl7Ptpb3
         KuOsnHNBNnNMcB9qZqjERcYVNV+uj/9jtgJBe1KQZKtqu3M0+NUaPqk7s9e6/VAwzT14
         Av57RaZeFOAhskc3eTbOxpe/ZEfBosxnZ399ZYK3Zsy9POuvbnY2OvnxxZdWEi5xiTNd
         1e3TGxj3pgeHhHQ6iobs/Hi/8McrRTcTpCsSEvgmCcxRXTeYFzOHjpABo1s93sGRH9xC
         X8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777715211; x=1778320011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezmD1eosO8J8L5bV2blwD7uKVAJ5uRnCIe2hKB1QaCg=;
        b=MHgEYl/61ZR10Cy7xP/XYVWT0JrpuTwtAk9ckENBNQHJmcJPx3Gza9X8imi8uO7WM9
         UqYdDuL7kUaP7raO+WCbI+Tk/uglj8ayv0Dz6svXuSz+dhZnKXMeqH01395JowNEQxHD
         JlQEBm83avegZLZAo0nnLkXYHHaIKWtB5962STTb6AnU85SEcqtyElQ+eXKx9EC/StQD
         v9Ixqp6TrOnt4034pULRRcBO88JChWAzUu8Ljd8BO9n8airENzhX3KBWO6JL4Tx+9f90
         7zvANNKoluiLG61iOVKvuZ1v5VUMIOkKaDRJSn0xVnIiZGy1kZ7fM1Nza3rUak5J2Vli
         62wA==
X-Forwarded-Encrypted: i=1; AFNElJ8LVad5fvJq4ozM3eerYJu8cPa/R8tpoG6NvCchzMF9J9seOcZCMKcAXzTdyi8xeMfR/AkdxiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKOQ59uQq18xyaHFiC1hlVD+u62Tjx+jEEL+5cbAWRIGFTjKKE
	+d7vJWFSonYzmcBAK6L8jPTscBf3ChBqT82IpAwYT2FwVuUk+CemDr1X
X-Gm-Gg: AeBDietW8hVdnkArO2qx4GMu3nM8ypJEVDQDB3rUKDIzze95Y0t12YZhOfHPPFs9amR
	r1IWcjygQrscd4vjRzb66lDF0PG5JtZtclJuh69cDXUMhEZEvLgRCVZXn1O2Gg8KVmkBgKo3jcC
	5TKT7gSMmWxg/gw0QkOnk3LyrdgB/XP8PdFURMERblSmQAcLfieITiI5jbvmNcJgVRl+vPHZtL/
	TBab7Jgx74ptfzCsJHnnPUGqbTu9e8L060ee4vq6oFyhMEv9omOYHZYnGzn1K/yAva5jS+0aP8a
	P+WGKU/bfW/huG3kJjfZuatnCbiYj/DGPbkRodKbFcQVxjmwNeVTCgUIk1xytY4q8r+ZEsmIak3
	k+H8cv6HOiu68Rc5Rm+8fYgQ1/Jw2g3dfC26nTWfFE1S8GJ06CxaYvbne1Ud2vduSTanHgCcoYn
	dh4a3lLaRvAmieJT/1xQBBoZJVfAy97jukNWpd/ZO+mpj9tg==
X-Received: by 2002:a05:6000:40c7:b0:43b:5672:efe with SMTP id ffacd0b85a97d-44bb36d17efmr4004334f8f.9.1777715211096;
        Sat, 02 May 2026 02:46:51 -0700 (PDT)
Received: from foxbook (bgt227.neoplus.adsl.tpnet.pl. [83.28.83.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7d035sm9943933f8f.5.2026.05.02.02.46.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 May 2026 02:46:50 -0700 (PDT)
Date: Sat, 2 May 2026 11:46:44 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command
 timeout
Message-ID: <20260502114644.76e6b5a3.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D44894B18FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242590-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 1 May 2026 11:09:27 -0300, Desnes Nunes wrote:
> On Thu, Apr 30, 2026 at 6:55=E2=80=AFPM Michal Pecio <michal.pecio@gmail.=
com> wrote:
> > When xhci_handle_command_timeout() logs USBSTS, does it help to add:
> >
> > if (usbsts & STS_FATAL) {
> >         xhci_halt(xhci);
> >         xhci_hc_died(xhci);
> >         goto time_out_completed;
> > }
> > It may not be perfect solution (race conditions?) but it could hint
> > that we are on the right track, if it works. =20
>=20
> This panicked the system as soon as I hit `echo c > /proc/sysrq-trigger`:
>=20
> [  141.683476] sysrq: Trigger a crash
> [  141.686970] Kernel panic - not syncing: sysrq triggered crash

Damn, that sucks. Any chance it's not a problem with my proposed change
but some sort of issue on your side?

Anyway, I think the patch below might cover it. It works for me in the
sense that the bus does get killed, without ill effect. I tested on
VL805 where HSE is easily triggered by disabling XHCI_TRB_OVERFETCH.
However, the patch isn't necessary here - VL805 doesn't clear CRCR.CRR
on HSE, so normal abort path is taken and times out, then hc_died().

Can somebody serious confirm if this issue actually exists in the first
place, and whether the patch solves it?

Hello Redhat, anyone alive there? Or only stochastic parrots?

Mathias, do you remember what's the point of the "Command timeout on
stopped ring" branch? Can it happen in any case other than dead chip?

I also wonder if it wouldn't make sense to just hc_died() on every
command timeout except Address Device. We rely on Stop Endpoint
timeouts to kill chips which go unresponsive without setting HCE/HSE,
because sooner or later somebody loses patience and unlinks an URB,
but this story (real or hallucinated, but plausible) shows that this
may not help when there are no devices created yet.

---

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index e5823650850a..3041deb67b57 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1761,13 +1761,15 @@ void xhci_handle_command_timeout(struct work_struct=
 *work)
 	/* mark this command to be cancelled */
 	xhci->current_cmd->status =3D COMP_COMMAND_ABORTED;
=20
-	/* Make sure command ring is running before aborting it */
+	/* check for crashed or disconnected chip */
 	hw_ring_state =3D xhci_read_64(xhci, &xhci->op_regs->cmd_ring);
-	if (hw_ring_state =3D=3D ~(u64)0) {
+	if (hw_ring_state =3D=3D ~(u64)0 || usbsts & (STS_FATAL | STS_HCE)) {
+		xhci_info(xhci, "kill the damn thing\n");
 		xhci_hc_died(xhci);
 		goto time_out_completed;
 	}
=20
+	/* Make sure command ring is running before aborting it */
 	if ((xhci->cmd_ring_state & CMD_RING_STATE_RUNNING) &&
 	    (hw_ring_state & CMD_RING_RUNNING))  {
 		/* Prevent new doorbell, and start command abort */

