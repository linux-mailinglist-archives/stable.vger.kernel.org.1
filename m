Return-Path: <stable+bounces-240341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H4VHdzj6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:06:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB885447ABB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4560E302F5FF
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746C432143F;
	Wed, 22 Apr 2026 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwkKD5Ki"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38B26982C
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869922; cv=pass; b=kk97w86AM/z8rHsSNQgeqFTBhFd+JxQnK2/uEV2pF82uf47uf2sHrrvOg5adLNWw2qvJe+d099dLDlVUhsIQ9x9EStvBakDpOahnwgGeQMB7Cdl0Td2H9C0VLbx7EAfxeJNYwbW7lYCWjQvtpHkBdA9NXIl7DumSjKkriWD8oic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869922; c=relaxed/simple;
	bh=078rttVyJWbDLtpUTmpCNyeg3LrV+3Yx+Iqwf0wDCYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8MbjxcDEo6kR1uV+B+R9A933jHB247RHRYdtQ/fF7aRHSwW4uM/Ry7MKkwded/kYT3I3n6iL7pLeOqulsDp9tZEV28s3gxj9FO5226PS2pqzp21zS16belwC9JB1LhXcuM98A9Xngk6oO7r/RC0DRSfhHUGaa5fbsIR1Qd93D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwkKD5Ki; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65318dafbcbso5631385d50.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 07:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869920; cv=none;
        d=google.com; s=arc-20240605;
        b=chp6ZIiqR3y+NSdU9IpmggqeFW4g3ZnU7XYN7J5b1gD6YQ+cTC8+AmiYFT/zvasCOD
         NdHWa4Py4CVF1+VyMaz2GfGFBJ0fLrl6yOLcZ1bLlAha+zaeHzUhJb0Z8j1PTeNQmosi
         veBqJ+cp4NmIMl7uBEMmVzo35LiOpGqznV0nY7t3DGT8kh13gQZUnkj+HPsxbVtds3yv
         lJfvZJokKS9HJMzjpVfBHdIb1BS1bVJIb45YOKIvWoGRQ1DPA45MGnNHT+6Ex5eiKUlV
         ZtmB8KpPt1y+Q9Kp6SM0VjCQDNKwJp/68Ibnsfm2J9ID2gGjrl2YyawxZfAy8ykoNRCZ
         CowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        fh=ssyaH8Jie2uUqGihtDDMA0btLASDSd/oHm/Ne2V297s=;
        b=bgqvKoyodyXFEuvmGu7dUqF+VXaOqqXGrXDjxl8b4D/l/Yg+TLnpBvkvYStnAD893y
         NHPuxun1hrlfZE/DxgALEpiPCGjxD7OFlRC/3bnFZy661h1v2J1pYtYl66OhH/5JIjvF
         STyehjEPFyYCMFKLSynbO3NoC19XDjcV15oR0qcuiLezNOxAVZmhL+ROwGkGLLCu7Dnl
         pUitYqPNT7MQGPJAgrBA3aIHIw8Uu2CQAgv3cSeAYYKxvKncP+JnaJM84l6JmzHZP14i
         w+cQkAiX1NRFhfpO77I2bAq5MWuN2nc90jNzZ5ffn9LD1pOZKPCdivNOL68yU7oVS6Qj
         +xNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869920; x=1777474720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        b=VwkKD5Ki9NpKUqQa6sLkt8/vMeRNjrS7bhzhrz/sEzDEbygGRCvdV1oBCuK22YoFSW
         2tTso3xLdzxj7b3bPIt2BYgujvXuBT9lZQFkrF+x+RUu+8Slnl0ktkzAOa7BxkISR8R9
         jUAusZrbcVLDR5Y/7HMgQFFjPFN8HFzZf+7dK/bBPD76nhdUZ2blSoLDDeAiontsqhIz
         8WTUWDbk68zA7EKqAF4xS524CZicbs5V1YyZLB2B5sYuvtdZv5P7M+Jos3fbg1OBBuLf
         o9I5ZRK+Kx7Sz6zGxWY7U+Rz7wsJduBbZ515++zBCtZ5UKrqxB3+4W/VQViQdjVle+oe
         pr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869920; x=1777474720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqyJWtKrH9oShmW+WNLiSnqWcym7LdgzARbMIJVVAy8=;
        b=IhqqxsCUfsUuNl1kwBN2+LCJcqPIWYvs09/kDVjd3N+7m4l0irzMO6wV8lcbguX5Pe
         bM1vZt2vw85r5mE6N8IziS0I6nE1uPaDgLwfr715vNkyzVhl2PW/aKfs4VTJw496m3/4
         lZc1oUuYBeWyxxIFNYzfD2grDz2lmjgFcd1hzsMaXP4IlnIZkcZDwBSMyP3Fi532W2No
         cOygfE/fRVzw1qzmdVqKfrZwKkCGeFV+mJ4wsA62mATSn1sGrqKOQFhsgifM0my/tzvn
         yZNIDbT8YhZzSjq7qU/yP8YiLO9tPo3a3qn59Hh1RWy5uwCbE5RwHtogb/wbnfKzB1lV
         pfYw==
X-Forwarded-Encrypted: i=1; AFNElJ/IML7F12MylEWdJD5d1eTTx368f5JwjpobTB+68sm8t2/yZ2Nvb/GQ7bPNNo+DqcS8R/gnLvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoAzpgYmlxTmA3yvaPC9/h0+xmgFMaBXtJ7dzN6mejxY+Qz7/
	y6Cv4EGJVPrDqp4fm8HoXGI9+3F2sK5n3mPdlHmsU9GWE6xBDt3Xd+skw8/WSx+qRnfW5MqS0OL
	Od+yo4+pUhfurHF/ZUofnXlC/0yqF440=
X-Gm-Gg: AeBDietTjCV/Mh39/gHnhLOm/kjb+ynf2zRoqMFgpapPzKW3hVxA8kKPwOJYUOOKvy8
	CxyoQWCzeIDGYHf+/uQqhJxa5lFv5qN54/VAQXu+Q3A1GwZp8QNCdFQhbtTww8XC0TWkP4NvXU9
	PDH2kcQufHpwOpIaBzZPQFTnYzLhp7vgB0H9W5nHt7cFq94XzrPysIhjor2pQ0HcJhbIcHj6Vyy
	SQLOhP8Ex0Xi70qkeB/97O3DQFOSYsll57KElSzdHVkrJGlNHmYqwB81IFW1DME80Hlmd87VaiE
	E7neW88G+2LscYm/HlQmkmXsA10VRUrVQy/oXxbNcSXzPVv+UpHImMgqng==
X-Received: by 2002:a05:690e:128c:b0:651:c5d5:1141 with SMTP id
 956f58d0204a3-6531088e804mr21017595d50.28.1776869919985; Wed, 22 Apr 2026
 07:58:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417221628.1674866-1-michael.bommarito@gmail.com>
 <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
 <20260421135639.3185653-2-michael.bommarito@gmail.com> <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
In-Reply-To: <CABBYNZKS5Prm+BTkpdPgArgODTEDgHXLjecfux=3ZW0r2x=UXw@mail.gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 22 Apr 2026 10:58:28 -0400
X-Gm-Features: AQROBzDekR93usvh9Pimj95cjSzQS5l71ZvY76cwJ2OQBfEIuaMxc8oI-vdcE1A
Message-ID: <CAJJ9bXy8CVjC4xG0zBcxi9xtiep33-uRGSysL1Q3FiqCN7Rt0w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM
 RFC option
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <martineau@kernel.org>, 
	Hyunwoo Kim <imv4bel@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[sashiko.dev:query timed out];
	FREEMAIL_CC(0.00)[holtmann.org,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240341-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:query timed out];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB885447ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This seems to be going sideways:
>
> https://sashiko.dev/#/patchset/CABBYNZ%2Bf3pur4cSsanQ1kvv-yORp2E0qmVLt9si=
_%2BFnnJup4Ng%40mail.gmail.com
>
> Patch 2/2 seems totally broken.

Yeah, not a great turn.  I am struggling to figure out where to move
some of these parts and where to put the guards without touching too
much.  As Sashiko pointed out, there are some preexisting bugs or spec
questions that I don't feel like I should be touching unless we expand
this to more of a cleanup + hardening patch set.

If we break this down, there are now ~5 different issues in
adjacent/connected spots:

Ones I was trying to hit or introduced:
1. Zero txwin_size in inbound CONFIG_REQ (ERTM RFC) - original bug.
Need to balance normalization with spec.
2. Repeated CONFIG_RSP re-running l2cap_ertm_init in BT_CONNECTED -
original v2 2/2 target.  We need the guard somewhere safe under the
state model.
3. Zero txwin_size from userspace setsockopt - original v2 1/2 hunk in
l2cap_sock.c.

Pre-existing issues:
3. STREAMING -> ERTM mode switch via late CONF_RSP - pre-existing.
4. l2cap_sock_setsockopt_old locking - pre-existing.

It feels like the safe solution is probably going to be at least +100
or 200 by the time it's done and more than just a hardening patch.  I
can take a spin at it, but I will probably be slower and more
bug-prone than someone else.  No pride of ownership here.  Just let me
know if you want to take the fix over or let me try again

Thanks,
MIke Bommarito

