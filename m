Return-Path: <stable+bounces-238425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM95JYzT4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:30:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F41084176F6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A3E73015C80
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C459C329365;
	Fri, 17 Apr 2026 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRL0InEE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666831A6817
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 06:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407372; cv=pass; b=pBWnfkWVhCSs+Y9hAxmr2siMwF8/n+PZqhRS+0AtOARJJGM1gg89TZf6NhFD9g+2HgobMP2fhqqtCDXhNtYUkH1AxydfEgVUJVv4gv7F57KeJtogNdPGr2zcrF+u/sGmcfl9mRyhgWN2bdlmXuI94ea9DGwRZBkzeYkek6GJEFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407372; c=relaxed/simple;
	bh=14+xQ1a1G1nEReDxZ/dXNTCYJEzLvvv8MSN6K/ZJ5yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeU5vpYVu+oLFgsDDcMaBBQdWcYjHcxnzds62MIkqOZQJaViCq36hhFtPuoBgv5dtMtMuT+hUuXclXTqlZ+q7kKq7D+2AC//ZBi+hn763T8s2HARvGr/qGPkLBWhTmv/GHq9F1JZGNA/TMY5vLHkxnsMsYUSAESy2XP2RIfw4Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRL0InEE; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651c366f7efso366132d50.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 23:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776407370; cv=none;
        d=google.com; s=arc-20240605;
        b=SS9dku1ASyuJzBJdZ495r8Motgf+TK12IHr2M8GVR3rltmqZvHQtwW8yNkxWfIjyiw
         jV207a5XtWgjunQelRXW/h3IQfRw/RdERifG/hqry1hC1Oe8YKdX5aKTCH0aNc4xLgpp
         qGqN4q6iC+iO4QjsH3MYWV5eVtw1Lt68+jwuCeX6WSII/kQMhupjtCFx+n+/HVTo4KlT
         b5+yvP5kK3yIOwyH3ePUKzx37FLCo2SSEPzxcw/0SCmxZ7C8WKtK/Vb7sXahL9n2h/Nq
         pGigBt93AJ0touBu7zE8K9+oymkJhwMsbx1erL45Lu8R2cApfxeY0fg+3KcfWuxAo9Fi
         jdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=14+xQ1a1G1nEReDxZ/dXNTCYJEzLvvv8MSN6K/ZJ5yE=;
        fh=fAGi6Z9OP4SOOYjKBqMGaZOvLDKrnga/b1kUmirv8jc=;
        b=RvevORw8jnMNdboGpF7YVXPgjoLZ0B1rHWF/jAA36+75So+oWeEEpMuCZZ/vUXyLzJ
         oFmLyQvXe+x5jujAHODVsQNzVSc1jMx2VlwTEiXARZYrChVkhLgZ7EwdySYFJ4TXOC76
         9pagKSIrT8wN5L3NAVVmsob6dhjVszuvclkLVn97p0ei6NtnKudERN15IRVe9uAm794I
         SH1PJXvd2lEZqqtHRImo9bRtvDiC92PN/RnOTQ65BbZjYtSWqebhb8hqn7kqFa6U9Xn/
         Ai4rM6byOZxQxQV0rp4/lWPEBpggmC7MNsp/UArZKNlih/VzerrFt/tSZDoBBoymnJSC
         ftOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776407370; x=1777012170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14+xQ1a1G1nEReDxZ/dXNTCYJEzLvvv8MSN6K/ZJ5yE=;
        b=dRL0InEEgFE8OsBi+RX1369T8RPHDBJVDlVRMP3N7XDecGfKlhFPWYzrUrQQ455O9V
         8MSFZnTzDAZ4SnJUlXRt1++ncGvRdcRB3jjBCQpiNl+doR3m4Q9i1fmdvPVA4lnRIHML
         5+uWpKDWSj+Y83qMk577S+U/qdzEwgV9zzaN2oXdxIKtXCI0FflPpC5mI9CHDQ4Y2cbk
         oapOtW8GQZikO0xISXJ9YHhl/Tk2hPWLByVMvxwgCR6r5OF5ysMYvHyqd24hMOLs6md/
         kabRS5Tre7qVZp/7+TyP2rg5OR4nP656muzT3CrfWqpnQ5WyddYMpT0Wfz9Z/IdnLMUg
         VEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776407370; x=1777012170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14+xQ1a1G1nEReDxZ/dXNTCYJEzLvvv8MSN6K/ZJ5yE=;
        b=JN51crxu+V/K5KEnsWR3n9By+jpSL9FeThbrPt8NSqFOTTBIDShdfoZGEXcm+AsGBS
         HcvvXp5dt3U1Uci8YcAdDq9nKOEEJzne/6h6v6ifFhx/5SkEwfeLHiAZ45vZI1iLhZj6
         WsreH4qMSQaejqarZGjIcm3DmZ2SkXvFzzMIZaJanFg9nALdA0EUHvQSzSd9jFyYL0qx
         TMK3w+XUu98SBW774XLyO9zlSlLUZr+SZ5gXsPzNfk9xGLv8NSN+Q9UD/HDo5/fAh0/9
         vqUaIo8Hgc4HEBeoZep79UbOael0O6QUIL9puqbOv7PiN7buCsMpsnBEHBYtPf8VDVIg
         R8+A==
X-Forwarded-Encrypted: i=1; AFNElJ+bQ4HEoC+jhpiWaSWfUoFxEeNlWCio6TaCMJwEgRaa+srg0Am103VKCMw1Qz9wygC9J6jH2Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30UsCIpgRZ5TxEWF0UH9QZsaDr0T5rZs5ZgiqoBrzjgfbHlzU
	zcG3q7bewRcQm9iXMBnoqGjnNzXQ5xqooP+EQko1m/xQsN4wHvueGHCX+RJ1G8qMtwJffztXEz4
	aFMzl2CgHlU38hH6ZLawNXVSxSUTuC+E=
X-Gm-Gg: AeBDietapXuK+zKBbLXZ9J+VeoNTTrVrNB0LRWxQ5/XsF1gA4Xu3Mz8TAzTKwC9EMJ2
	ikSFnOhBBS7l6sBuu0mNkyX6itj2jfTmPJhDyEgbTSDuMITiZRLttPDLSuEqMS4hS2jfMs4wJn9
	ESpTd06lYsC/FvM3WafRgEoJe0d7LWjN8AST0Ivp0VMCvwLbZHKZxdHexKwf8XvE1/S0Vqhg6IZ
	ysF5iv827IePZMylYGxuGlAYtVuD+APKRbfSD8VqBLBi6km2IFzHA1taBdlbpof3ORd/vrw1DCd
	KFn0xZPbZlMEScha1aiA
X-Received: by 2002:a05:690e:4319:b0:651:cf23:6612 with SMTP id
 956f58d0204a3-65310a12bb9mr1045818d50.34.1776407370491; Thu, 16 Apr 2026
 23:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416165935.3958686-1-lgs201920130244@gmail.com> <b1a6b96d-07d2-4a19-b9db-2cd8d878895c@suse.com>
In-Reply-To: <b1a6b96d-07d2-4a19-b9db-2cd8d878895c@suse.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 17 Apr 2026 14:29:20 +0800
X-Gm-Features: AQROBzBxiJ9VZU2-aWBk9HO70GvYytY3hQ-cUOKrLjdfj36nQ9VfZ_4L5Zu0VDA
Message-ID: <CANUHTR_qm94JQn-FKa9BfRgxadXKbXJmJEof6ZdE070=Xi4mGw@mail.gmail.com>
Subject: Re: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe
 error path
To: Hannes Reinecke <hare@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
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
	TAGGED_FROM(0.00)[bounces-238425-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: F41084176F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Hannes,

Thanks for the feedback.

On Fri, 17 Apr 2026 at 13:56, Hannes Reinecke <hare@suse.com> wrote:
>
>
> You must be kidding ... EISA is died over a decade ago.
>
> If you _really_ are concerned about this please remove EISA support
> completely from the driver.
>

I agree that EISA is obsolete, and I understand that this path is
unlikely to matter on modern systems. My intent was simply to clean up
an inconsistency I noticed while reviewing the existing error handling
code.

If maintaining the EISA path is not worthwhile, I=E2=80=99m fine with dropp=
ing
this patch. I can also take a look at what removing the EISA support
would involve.

Thanks,
Guangshuo

