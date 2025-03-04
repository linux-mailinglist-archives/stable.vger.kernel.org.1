Return-Path: <stable+bounces-120348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECDDA4E818
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B319C5453
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5C24C063;
	Tue,  4 Mar 2025 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atZn64py"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BA82356AF
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106839; cv=none; b=g8gW8OBSi6N/P513a1tG5p4suFh+MVUkqEIdWZ3nrdm2dBq/n7YnwhKI9Zz1FAbN5vEvB8fKLM6nXoa4u9HXG2KmuDyvBX7fR/IatIdwlo29Xkp7C0284hLvkUWp83CfZiVuBGdzhVncbR+Pqdld25JIJ8kfo1zkD7ZKaap2e/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106839; c=relaxed/simple;
	bh=i9AaRmNaRrTsHMZnXo/f+7IzWKY4i52bwWQ0pzFnb78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+WAU7CjV1/caYOPOcu75xIUPgB2cZ63G345M7WtaVEdEXa2EQLmYs/qtsgMLQuL15oW7Hs3HXknb4lp6JECAlKO8VokoxyKkppEhS0zPKmMRI47cGYjV73sr60J4J/RGqfSerxnnWtGsaoJhOV6bs4nsKGsHFRrwgdCOzJtC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atZn64py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D228C4CEE7
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741106839;
	bh=i9AaRmNaRrTsHMZnXo/f+7IzWKY4i52bwWQ0pzFnb78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=atZn64pyvA0slngpKXdwlPpE8PNSJ2k8CQxi83+P+Nz1/tCWJtS1ifeKlMlVHEJg5
	 BaSl5eUvfvmW49KUVrrUC7NVVWAc1HRYa2OtrjsvPj6bJmfz9ijiJQw5FJYcBqq4Xb
	 /RqHEB1H1ANirqfMofyJjkvBU3whbcqQ/d4zz9hefsjL+JgEwLrUTPjamu9fJlvJR/
	 HyA3vG82qv+w7w5iuTS2CoHh/f68GGVpSdK53y0a2naJx0Zd1m4VVqhmftYviuHsr6
	 AtpT1+oGzwl97UtebJjQb3HPvBb9Mex/j+DSautsS8rd0L4LzHPZwra+xGe9bhOIgG
	 bnk7vFh7+5YKA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso4576928a12.1
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 08:47:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYuj4KTx+ZHHZXcZ1OT6sAD3s1d1oRRE5/6CSPyY8T9aBOGiLnZBsAFdWysMeil50clYLuZ9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwljIkozc9raHXZ+dclc1uog4fv4wHCPgX+SRJuuF8Xq+Eb+M
	u0aw4NKyaEq0NqDoDa/Eu7TbxCJtGNN34THFSdawYlSPK6p0dTX/uF/GNN3kwyYLj7jYA/7cIuf
	5fPcmJmCH5lQdi+3r3j2glGVORQ==
X-Google-Smtp-Source: AGHT+IGMhCRpWBToxlDYtz3b8IJ4SttqY67OpV6DQFHXVf44ydtoAWlOil/KJjzLQHQLU2MiNWMAtbdbft16FZx1vdU=
X-Received: by 2002:a05:6402:270d:b0:5e4:b66f:880b with SMTP id
 4fb4d7f45d1cf-5e4d6adbd26mr21719474a12.6.1741106837626; Tue, 04 Mar 2025
 08:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025030439-announcer-lard-995b@gregkh>
In-Reply-To: <2025030439-announcer-lard-995b@gregkh>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Mar 2025 10:47:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5-vMy+1nX8tE=sL=vLYOAfxyscwg3etzkrg1wRvSd=A@mail.gmail.com>
X-Gm-Features: AQ5f1JrsUDofj4iMKyp6VIcqKLOUJguVotAOz6kQFvL768RkbSSkrDHtwsdw2Ps
Message-ID: <CAL_JsqJ5-vMy+1nX8tE=sL=vLYOAfxyscwg3etzkrg1wRvSd=A@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] riscv: cacheinfo: Use of_property_present()
 for non-boolean" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: cleger@rivosinc.com, palmer@rivosinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 10:43=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

No need for this or any others like it to go to stable trees.

> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")

Pretty sure that is not correct as of_property_present() did not exist
at that time.

Rob

