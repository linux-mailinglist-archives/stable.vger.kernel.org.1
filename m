Return-Path: <stable+bounces-211501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM1oKOTMdmktWwEAu9opvQ
	(envelope-from <stable+bounces-211501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:09:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F368368B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8BB2300100B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF2921255A;
	Mon, 26 Jan 2026 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikXkOnDZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563720CCE4
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769393375; cv=pass; b=ODXSe3wMp7+D3vP90bxoDLUR8dSF5eqhIFj3wWK3urccH3390AeGhTdm4K+vWfuJl5KaT0iwRpAEN08UOMqbwBYrJDQlaqA6hnvJDfzYwjKEa83cnQy+GZ8hv3NpAzHE5z5s+Pya59+75YeR5pKBPZyPBQNiPu8UTK1ncXux650=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769393375; c=relaxed/simple;
	bh=Jz3I2xiOMH4dsSqRr2L1xkjQM/X0CJzHvJGI4kykhuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfbXwVR88nW3AmqtpQX20vW+UtDCVDBxESiK0fwE2RMf163bI6MPEGZsoeLv0EdWNwO3gCSacykyrsRnPoCUeWVtau0iu1go4i8zB/nPQ30QfByaL990uFmu01ZCg/4WbJXVLPBHZyRmpyOWHOYUSlcZ7wB+h94GjVfTfcqslCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikXkOnDZ; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1233608c7e9so503334c88.2
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 18:09:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769393372; cv=none;
        d=google.com; s=arc-20240605;
        b=HpBNDcmS+vWuIqCmKxQ6t6xc822dOzEsV5fxnOvSslhs+ZMlgceAGkFgDxUTgrGnfK
         SnvqO4P0dRJQHyZDuhpro0bJG2/6Z1w8Auyjf8sROuW+qzOuxwaciSMp13TdU/fs4tZd
         IgmGY4LOrAsy3qlP5v85/oAm1T5vC239Bw6vMEKtlqzNszm0mC0UqCka559qlf7TxF1e
         CAsnB/68G72X/othbVn8N7wrHa2/Nul2ml1VCHct5JegvpURnhrAWLy9pBdhV7Ykw/cb
         oAgMhSS1QZ0qigKkgNF4QjRs2HEyt92uTZlPGbwdeu4lx1el5YeF1MlfPafpo1GSj/xO
         Y58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jz3I2xiOMH4dsSqRr2L1xkjQM/X0CJzHvJGI4kykhuQ=;
        fh=1iYndo15FNl/dwtIQ2fgHBBSPvPybPo/JEmHeGIVdBo=;
        b=jR2vMx3fim5cnBIuIyzjFjscVAJ1wwmhXE6IxY4VwoQKxetKSligQj//UhRSWvGBA4
         XexLYBOeuZzz7p2JWku4ouAgdj66THQd/UXTTYkNAHzY/CkeYboWy8EUs22GqLlS9GgP
         Kqk1m1CCcZFUEY3dHqLIXAUl/wpIETACm6Xw0kVHBd3MdOuPInvu813ecWRPylEMQmjz
         6in3k+t3fSWCJagWWPRSi6OcrfrLiU29hB1Od0pz+b6M+CcuvEv6F8vqpEueY3htH4pX
         omKu+ZXAbUq3f9XVERbmBh+BazV8/dgxO9GC9Cu1ezm2fq5FMyrMC0OOqfhapvEim8Iu
         af+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769393372; x=1769998172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jz3I2xiOMH4dsSqRr2L1xkjQM/X0CJzHvJGI4kykhuQ=;
        b=ikXkOnDZbTAAhPceMdGjoxUjd88fW8di8pcAvxrUcI1XsG0zWe1FWOrWyVoOfNz4EW
         +tFqtSYrPBn4f1wClUs5nduh9xJ7WCMrXEnk6ygxTqymhC/srl5dyGrrEMUNfpje+a0o
         RrjrYCpV2TR2RQIc/Xu9Ice/mLvD8HVGfFLoEC06hHAqXjjBMRc6n1o8m/zOhwQJc9cF
         V0zkRL2MfViPdYWxZWovI/jqR0aMyrBGyEYBflmPKhPI9HyqTN3WSvvx3u1MTscveiJC
         gtiBJQyG8YzFQ4/KyeFDQWsrSVwKpouiAJDENx4FYGN1R4dKReH0FGXZos39IPtYPPxV
         itYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769393372; x=1769998172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jz3I2xiOMH4dsSqRr2L1xkjQM/X0CJzHvJGI4kykhuQ=;
        b=UJY5gELy1Ki1jLuEpU9CN2gM9HgfLtnn0cNkrqsweuFWWW5o0bhncpbs8Rw9UHtmOr
         4f+iC55XbAtLuWTPL1jo6eD1m4LE4MG9mQ72cdpsOFrDuQ4PD7uj6PnCiVoxDc6llb89
         dSgL35zgz4DKgeB4fxd8gv7iXLrs5oxtkccMuTA5akp/N0YFqhGUdEqaWTZ3DwQGSn22
         peh6NkeCK8hT8rC0ndtP7Eaj2+KyT1Ad3ojMPW5onnx0SRBU/6KsoDntdbprMnOzwnS6
         yPc/a55cp633iFBNMbrcTjWQyAZoFxx8/Jc4BGClrXRMX8YLWCMbwYWiVYcSVjQzaiGt
         XkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXtK/kpriLoxcQ7re1PeEi8bcKP7nt+LbRXPxO3+R9XcunboeQHp8y15cHjdB/U1Qva6hnj2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/PCdsgKdA1JsZ7zBtgj30n6ZwlPaScxka76Th3JPv1+7wYwR
	nNIufneTYZvQ/MrX9FLW1LneIMJg1h0fnZO8j0s+PplYUmfTEumpq+vynw16xnYID95qZRsZxf+
	z8gf2gBIEQ99bohABQyM5N8RLqDVx09Q=
X-Gm-Gg: AZuq6aKRlr1LzYH7ZVcFYkI21FzvYXuW+82ads/RYhSfWa1+19ENRFxoVUMpbMY4Os3
	z4vRKi41F2hWq9XLL/9RvapMPB2YT4SqdYmb2cck507GTdYXgZH+XS1wnfJltRsUdCpz772wWKW
	OdVgkfqF215p+d3fU7IiknyL7A/5ilM+TCVoatnDrqlpeEE7UfSZBbvwpuiJu5ps7gTra4Zcf5y
	cq08yXcXu1DfX25Ka2W6wParL4HAYlPTzUPCNvtVr5NeC8AV0htYlcDwiNQdQ5U0NYj75eW8+JK
	p/+AZycUdAZcFn9Yv5JwB2h5p69ROv+WyvZI3bGAg6Q1VE/HyIS+j1JbbdOFgISr3G1T4BJC23r
	LY2k25RKHFmYu
X-Received: by 2002:a05:7300:fd05:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b764827c0amr701434eec.8.1769393372121; Sun, 25 Jan 2026
 18:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
In-Reply-To: <20260122-rust-analyzer-scripts-v1-1-ff6ba278170e@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 26 Jan 2026 03:09:19 +0100
X-Gm-Features: AZwV_QjYnttxa8bvLMHgNOmfF2FVoGkMDwahOX10J0pKmMAcqi3vkBCQ8sevelg
Message-ID: <CANiq72kkxS9ACvR52q03AN+WdFV96cK+tvejnnDXKZTKuKZH9g@mail.gmail.com>
Subject: Re: [PATCH] scripts: generate_rust_analyzer.py: define scripts
To: Tamir Duberstein <tamird@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Fiona Behrens <me@kloenk.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211501-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,kloenk.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kloenk.dev:email]
X-Rspamd-Queue-Id: 29F368368B
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:53=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Generate rust-project.json entries for scripts written in Rust.
>
> Use `Pathlib.path.stem` for consistency.
>
> Fixes: 9a8ff24ce584 ("scripts: add `generate_rust_target.rs`")
> Cc: stable@vger.kernel.org
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>

Hmm... This introduces support for scripts, right? i.e. it is a
feature, or am I misunderstanding the Fixes:/Cc: stable tags?

Also, I don't see the Tested-by from Daniel -- he gave it on the last
patch in v4, but not this one. Was it because it was assumed that
testing the last patch meant testing all? Generally that shouldn't be
assumed, e.g. he gave two Tested-by tags, so I guess he didn't mean to
give it to all.

I would also suggest on apply to give it a bit more details.

Anyway, this seems best suited for rust-analyzer-next after the merge
window when the above is sorted out.

Thanks for reviving these patches and splitting them!

Cheers,
Miguel

