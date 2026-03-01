Return-Path: <stable+bounces-222438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMCjK04RpGlcWQUAu9opvQ
	(envelope-from <stable+bounces-222438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:13:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D21CF0D2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 11:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2165301A733
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4792F3358B6;
	Sun,  1 Mar 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4CvyYGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F533509B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360009; cv=pass; b=MJqwMslVUcpiACn73x/+m/LJhnYhUfBRsSWvF2GbtPyC1SSnd1jbTibaaFOrQbnJALcANOIl9IIF9YF5+7N7Tc/RbvJpg/QTqRi0TXPZDAGa+Kf2HFqkkLU/faODAGUGecisFZoXfpz5KI67c7Ls5bGVl0pCqBY7QVPZik8CF3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360009; c=relaxed/simple;
	bh=75C/JukTvKdnXwRgWlbYQi4lAka/pdpoSGb1wX+7VBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8/8fQ51qiR5vusaSikP5u8e9ZESRX8iLpZmo7L5ax5W6ef5SpVjKuMChpyT7l0k/0C1U0u2kZdie+EVoOva81KiiF/17OzdCXwz6zwijQy8Cua7MTzHxnhkG6vf2r5eeIbipCYyehXvPF375T4BcE3zaZ8X1FHoblt/BRFirbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4CvyYGd; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12739fe9a0eso226698c88.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:13:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360007; cv=none;
        d=google.com; s=arc-20240605;
        b=D1miY2sc0X4tnREbjUtGm/HRdMz9Ofp8NfCnYr6Ss8lvTiY5P6pttXzlVhlKFglwR4
         zfSc27mMMOyRz9IXHPP0q73qhTinFoJqKk9NsquEBkAu7NgQ+tYUI2qwNqIq7OpsaKAL
         NEhPee5/2dVWGp6QMHHXQ78YubYTjeXyp5bJEI4BX+/NmJOZs4WNPaCxlPT/Oakv5BRJ
         XtN0EtdjwRt6C2kjpkq0+VmLlBT9ekLCap3xgBH9/d6EV0s6uXveWrmKnIghoTqBYMIM
         /LlDUE0fxgp3ceWklxiSRRWXPcvvihsZ6Zk1vEYvt9qJHOAos0U8rqF6S8nfVO9+G5G3
         mCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75C/JukTvKdnXwRgWlbYQi4lAka/pdpoSGb1wX+7VBI=;
        fh=6SlAK/s1LDjYOpJGfmZa0f6MYkX0DKJLke/nL7xIdlg=;
        b=J+9gVultSeFbKKOoMGU5dSspEGbUCwO5hUTIpLpGcZp71MlihtcvqpBBiYUCqc+mne
         JzK+jhtqyTFtJTzlWAyCx5nLqaAMdZsupnKcL+rm+9dj7woPbR/SPydePqKtUttE9iPo
         hoA5piDIrYmbzFocqx7Gx/TSpAGdk0owmWsSd2NA3Dw07QahvjuRcsxYxwAW1f7Dla2w
         7koOgmni5/oAkj/yEtdK0wan3WybJPiWlNoqFSK8FCG7OkKe8l47PCJASZQMA6LueJvf
         d4IQjKOwa6ONc8t3v0Kz25ne0VR526vc8/DDSX7HQHC0sdZW/yBjfAa8Yxkv47CE2cns
         3QeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360007; x=1772964807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75C/JukTvKdnXwRgWlbYQi4lAka/pdpoSGb1wX+7VBI=;
        b=b4CvyYGdoTB/HA6JgVYkwBhfhKvD9AqB9poXcAbabtbjVTcg4GDQmRDlXQgWxmcVxY
         7JM6ZVXAMcoCxgXPXE3bs7GhvkxCGnXMslG8TInGnNUXdRQMZh9LpOwYLulM6a16flhq
         ki0O1PtxyI3jNRq1v+GLk5gu/Skxf5NT7qF1GbCyWTPWlKd7OKtyhSmynm7b4AtMz8UF
         IRy/Xe69OjmfR1OH2nelCLJHS3kuC9Q/g9VViLfCqN5pABe+dlE+N69F1YLxoHiO6pmk
         VmNnH0pzkHzeV3G3h0JcecVM3oERmmBoud2Lhk0uFEiy2Tx/1iXgbRIna1UnIzNP6b3z
         JyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360007; x=1772964807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75C/JukTvKdnXwRgWlbYQi4lAka/pdpoSGb1wX+7VBI=;
        b=SO2ghPBOrDsWlEenniZN+dx/p2uIYmfPeYihVBx02B4Bmj31RNgtvGDlFtHh1tQsPx
         anTHdZTl7dof378Hfu3sV1TH9Z3mabZP7O8OaJ4S5cKgo/jgqeOA9wf+z1o6M/qnDiVM
         xe4Eekl6eiPeA3gchsc7r/sVYjXjluQ3hWEBJukQIumaNGvWG1yJTMjLvnGCKQOXO1+z
         C9bOqJnbQh6wyEPFJRLT+2RGim+bc1WVewoyO8FvUqA5TMRTW4RasgNJVSRmHnVR+tiF
         wHRRzzmpzxJWGh+rEentY5s6YQYumT1u+Vn/iZxUugsSirEu2GD9M2yrHUyH5rx/VqIw
         hL0A==
X-Gm-Message-State: AOJu0YyzN2tf1RY1+/V1B6G1zHkmEh+H7EBCx77bGOETGPmXesvVgg4a
	RuwU5Fpi0PhmGT8zun03kssmKrg8b5/zRYFr86e3FhIUIknHcLyz50142wWncMCCzt7lzacRm8v
	HQwEVMFCuZRAM4aa7QORC7lFU34IId2M=
X-Gm-Gg: ATEYQzwFvz0o0q/7gCkWd0HKZMyj9mAtgd7btX2HxmRGVtmkihEh6j96rFdDqBB3eQZ
	BfmWYIaFNP/oXdqJk0vf6t79qdcPukEGE9mvZpfhJHgyKYIim3jPMY39t1iQ3/ywUB0AUw8745z
	qw3vOYUnhNYuka4tjSTAGyQ4nYRMg2L8jI7O3UKudoVUGBTr102XrlpBd2+jinuruLu68tlurHR
	77qp0y9hIBLK5fnWm8MszR3Wr2Mf00f0zF1KFFj7TVBARj+fQL0Izip+ahIPGuhX9pjtsRdL+FG
	9YaZsRLtY9SyNo2fUuIxJ+P5K1PyBRH3eEI/1vLUrXJF4qybHZaHc0w/qwRWN/CXlCXgseLZ4i+
	S5M5S9Y6/4fV6MjyXVQaRR2ncrkrd
X-Received: by 2002:a05:7300:724c:b0:2bd:db75:c28b with SMTP id
 5a478bee46e88-2bde1e90dd9mr1533864eec.7.1772360007089; Sun, 01 Mar 2026
 02:13:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301020545.1734572-1-sashal@kernel.org>
In-Reply-To: <20260301020545.1734572-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 1 Mar 2026 11:13:14 +0100
X-Gm-Features: AaiRm50nMriLVyJIwduMFuyQbOs4IpGjFLyo6U0eJZtJzgEz1pwnRPv8P0IIuaw
Message-ID: <CANiq72n-kFuv7QQ3FV9cwSrX+Vbmsf6R2A-AeUNr9wsMcUqyPA@mail.gmail.com>
Subject: Re: FAILED: Patch "rust: pin-init: replace clippy `expect` with
 `allow`" failed to apply to 5.10-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, lossin@kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222438-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0D3D21CF0D2
X-Rspamd-Action: no action

On Sun, Mar 1, 2026 at 3:05=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

There is no Rust in 5.10.y, so this is fine:

> Cc: stable@vger.kernel.org # Needed in 6.18.y and later.

Cheers,
Miguel

