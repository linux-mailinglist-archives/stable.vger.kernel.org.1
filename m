Return-Path: <stable+bounces-238423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLXHIOPS4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:27:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718A417673
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC9530F84DC
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F336D51D;
	Fri, 17 Apr 2026 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQdq2n9W"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E211B2DCF55
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407128; cv=pass; b=TgG2DPr+HLGlFnqIF68y6nJzlmFZGuYQSvHbyiOrBKvyzZ4hidoxGpNp3pgLgXjKgN3kykV01XkQYyPmCR18rel2qh21oL/GpcASeSOPTjqq3HlMqN/U6dROLuO0PmU+P+yq5VRscNWn2BfYYfnwDR7tPeeJc3CkILQl0l1sMss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407128; c=relaxed/simple;
	bh=GQICckAKjLzrssi5/n/p/RByLwIZn3HWZrGojwIYRR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UK2UDhaJ+7Jtts91k70q0Wlt1hskUDOuyxbuQPST2lHSSNML6RZXd8xVUoAyuvvnWJFXIx0TNpe5TUhHOae/9jh622nCdbnsO4CDx9ZLiQI4W/18XKEy8GzeWMUYi6T1F+XdF2c3QRS+PR7raMugyZ16af/ETQ44h9v/n36EnvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQdq2n9W; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-652f220595fso362270d50.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776407126; cv=none;
        d=google.com; s=arc-20240605;
        b=HsGHATKnxMb2P+Wekw/iTWJ0lkGRabWHGHWbxMTqALaBUZyGcs0zqChbGfzFQvpMko
         snZg/eYAjCrx3AIufMVadP+Qqc4eXvxoBTzSKXewsu6Eux4KHCkfYDeHFgs2Efwm+KdM
         rYxxjBjxElx5+SWy49EVc0ijXB+ueUy/i0Sq+AChw+azYtQNZ3dOHojagk709Xdr1oKC
         Mfru+vgWtjoNuglW5IL531gqew+1PAMd/G1HO/UEXfEvfP/xmMKBQ1Q4x9RMuA8CQkYJ
         vsc4yrkjZrdu/7HLWmekrW9QVQrnF7O5frwNt2sLxAem+Pwt5FPfUJKBD+rHOiaNAUNY
         jR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GQICckAKjLzrssi5/n/p/RByLwIZn3HWZrGojwIYRR4=;
        fh=RmBEfi6yTyojtAk0D8kP+O3Hgwh1mcKm/zCCp98qt08=;
        b=cc9C4fdKzHIH1aRyRzowSDvHMI+NPam9f4nDb4JlzLlPyWW7gUznccIBvpEEfBURSb
         6bIZuK3upCk9f/z70I705q3wviryGhs40P8W3feoI7E2sioSOXHtFHt7MZXEWSGeqY3i
         Y2E+nJKGsHlsZ+f0zfxmfJHmay2KjJy8wd3qGuWl2F6l2BCNyH0Fu/bhUXDGVChr9X2J
         7YgcngWVcFr5nraiRslm90FnnnLalr1qV8tFO2QPals7ggtn3RTg3iDBIEW521XAAL3L
         AG3hNprDh5/Ea7d4gvzNBcZX56z71vmn9veXUAFbkkbeyKEYEeWGVoYLTn++u8UQWN+9
         Bi+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776407126; x=1777011926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQICckAKjLzrssi5/n/p/RByLwIZn3HWZrGojwIYRR4=;
        b=DQdq2n9WUlaLuBCam0pdqbcAbBuaZhtuUO/ATN+y2gsQRhK5+qtuRzHVMbk1uaAaz3
         1DorF4Gi0WmHR7X4x5UTeQvwiYtpYwsKSfEK89V7aVTd4lL/hpPK4EsIryxo1lupDzh7
         M9BzUA9iI6QlSzOn1Yd1C0lOo8UmRqV6WVqb0NvlyAAi0OsD4xHxZqSr+b89l2cguQ53
         R2M6a6idlNPFiSC2rDMRkTtgVk8OsXt9Y/thq+RxtDpDE66W/PUH4ghbJH9ifHHdHNax
         VE/N2onrEwDpdtrG8ORFVsRBSn0ERH2bBcNAKAOa5UWxK/xMZlzuzVTW9lH+WenPYVNA
         bKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776407126; x=1777011926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQICckAKjLzrssi5/n/p/RByLwIZn3HWZrGojwIYRR4=;
        b=AnmTOowWUQpvKVAFFTXdlsI7+1PPLpFO6p/7x7z1MnWNqaM4fK2tw9Pu7IZMc+p3Mf
         oD/NhR4TF+bZpcIrCSsKW/HThhmCV/e3NkB0c2rM4VxwbjApktSSlYGsPQeRQ5DmVRs+
         7jxYHEwDURQpf8IKXGJPgpgS9p0HsCJCLu83hMOozJtJ1CllRYr2OLhkDIyFp+CznebT
         9+Hb2uT4g6Ppt+TCGe0XTfTJYLn/iT42PB6A64OafuxbYdl/zxoBq9ohwTJhQgOw5aI9
         b5ktNTQ4ianTTskFmDSlesbHnZPDgzBB/upLHrVNjn98hE4WENSvVuSOhpquuHvh7zcJ
         +rDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t3bsOVBei8DCE1aTLbIK3SNswgT9waRmTpwugwcghdbGY651OsD8xfN0073aUmoT6KaZbpSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAU6hTrVugvrT+0U70+rw2wZPxTWqWYc+0yQ0UBO5c5grEc3vC
	RrpUI1p2v1GyAJntImw7wgq0jkW+r7wa+xUxuIkPHQPr/BpRvFkp1aJZfehj5/9P0+ijlgb6wWz
	YIx0/xl2fNeGlJhMyaw6UIzo1jsRW3B8=
X-Gm-Gg: AeBDievxr25PecJaFT2nrcsQUcr5BsZf+sqqm2wsX7XSCwOmYjWC1ALGhMkUZn2JawZ
	h7FluuWqu9HBDMvwYqw1ibc06A5dQ2JgcVzK4AdiOGz+6nPr5qmbrrR0D4jW/CxwPScUM3SEkaB
	/NblNO8fBHmVeDcnM/RVuESEZLlsyA7Su0aWMJPb/0lW/G6qDm9NlqWvPJF7j2j61jgng09ISDu
	Qdffl1Yl+nOFRH/DTg8Q125skaD6BW5WpJ7zoc9DcJYPeQxDS5F4iBVD/NmlkVWne1asQfFoFmq
	0WdRf1uKVXzwVnk5UHjv
X-Received: by 2002:a05:690e:4289:10b0:653:285:d180 with SMTP id
 956f58d0204a3-65310a8fbd8mr1124657d50.61.1776407125978; Thu, 16 Apr 2026
 23:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416165935.3958686-1-lgs201920130244@gmail.com> <aeEfqbaI6LNObJAC@casper.infradead.org>
In-Reply-To: <aeEfqbaI6LNObJAC@casper.infradead.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 17 Apr 2026 14:25:15 +0800
X-Gm-Features: AQROBzAWhi0EQ1TZMfMFXO9yfwCQdkrn-vbSB6OUbjnZ7VolNnyLb6shB7Qy1ZI
Message-ID: <CANUHTR-BAvcRGy8YBMx0tgS4HLDTdMH1JkkLM97Sk6JO7JiUnw@mail.gmail.com>
Subject: Re: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe
 error path
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, James Bottomley <James.Bottomley@steeleye.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0718A417673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Matthew,

On Fri, 17 Apr 2026 at 01:43, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Apr 17, 2026 at 12:59:35AM +0800, Guangshuo Li wrote:
> > A manual code audit found that advansys_eisa_probe() frees saved
> > Scsi_Host objects directly in its error path.

I understand the concern. This issue was found through my own manual
review of the error handling path in `advansys_eisa_probe()`.

Specifically, I first compared the error handling path in
`advansys_eisa_probe()` with the normal cleanup path in
`advansys_eisa_remove()`, and noticed that they release saved
`Scsi_Host` objects differently.

In `advansys_eisa_remove()`, each saved host is released through
`advansys_release(shost)`. Following that path shows that
`advansys_release()` eventually releases the SCSI host through
`scsi_host_put()`, which drops the embedded device reference and
invokes the SCSI host release callback, `scsi_host_dev_release()`,
when the reference count reaches zero.

That release callback does more than just `kfree(shost)`. It also
releases resources associated with the `Scsi_Host`, such as the host
IDA index, `shost_data`, and other host-side state managed by the SCSI
core.

However, the `free_data` path in `advansys_eisa_probe()` frees the
saved `data->host[]` entries directly with `kfree()`. My concern is
that this bypasses the `scsi_host_put()` / `scsi_host_dev_release()`
path and may therefore leak resources associated with the initialized
SCSI host.

That is why the patch changes the error path to release saved hosts
through `advansys_release(shost)` instead of directly freeing the
saved host pointers.

I also noticed that I accidentally removed the final `kfree(data)`
while preparing the patch. That was an unintended editing mistake, and
if the proposed cleanup approach is acceptable, I will fix it in v2.

> I've been told all your patches are AI slop, I'm not reviewing this.

If possible, could you please share what your assessment is based on?

Also, if there is any technical issue with this patch, I would
appreciate it if you could point it out concretely. I=E2=80=99m happy to
revise the patch if there is something incorrect in the analysis or in
the fix itself.

Thanks,
Guangshuo

