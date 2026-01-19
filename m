Return-Path: <stable+bounces-210393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7FD3B70D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 20:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3358E30E991F
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A873904F9;
	Mon, 19 Jan 2026 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyqqJWic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645038B9AF;
	Mon, 19 Jan 2026 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849961; cv=none; b=PVe7pv3xabHUxnPJ1EjDJ5PG6KLhmI6MsHYDiMks0flkPMmwLjtdFDpblgUw/s7kfsygknHVO+T7Ppf+ABLBtxebSChCYnclu8+pqScmLprhy/HinCgPW0/khICVSoizurzZD4iH3wKMi6LNMMhEjZW96rNmNwto4/8/BMhqZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849961; c=relaxed/simple;
	bh=b37oGfWKh15k1xUheDvl8XTRT+TdzeGUFsirBI+Fe/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0Pf0vaggwxzDrVlGr29Zh7BRy7KHdG3qPcCYtVXdTqsc1NN1w28QQpVIAKibUf2QjvGpUcwrocuzW8F+F4viWTunCt3MxUcnHiy92S9n5pD2ZlqYacp1Tc9SgG+8q2YnSuwM2W1+Vt+syMLs1eZaLS+GvjZJyqQClhpWnMCBGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyqqJWic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E64C19422;
	Mon, 19 Jan 2026 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768849961;
	bh=b37oGfWKh15k1xUheDvl8XTRT+TdzeGUFsirBI+Fe/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyqqJWic/mHBGC8TVcZHDbkNDqil0dWmxauplZbapR/szDc6UGWreM4Hm3y+U7JXs
	 hXnXTsxvH74eJY5gcQNiOyNpks/Q//YNCSP/4xQZzcGZ/tOhIz5IgpOnDBvbpG8JFz
	 I6jDIr/wx8gDHng8LA/2PLYSLJ+jlRvnMnRo9OE7SXkK9IlhjOyN5AyZZrQQacIkX0
	 yRVTPYSIinxC2GAxZIKYatOcNdyUp21kp35kBuHSlLeTKo9JEMlranX2Kw31XYojV9
	 adsDh2I7uhm90FPnhmZW39lh/mfgsVnQPfxtI8AtDwz6A6Ux51mj/Lko5ENYJ2TWSP
	 lA/ZOX7rzcwnw==
From: Jakub Kicinski <kuba@kernel.org>
To: p@1g4.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [net,v1,2/3] net/sched: act_gate: fix schedule updates with RCU swap
Date: Mon, 19 Jan 2026 11:12:38 -0800
Message-ID: <20260119191238.1240882-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116112522.159480-3-p@1g4.org>
References: <20260116112522.159480-3-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/sched: act_gate: fix schedule updates with RCU swap

This patch switches act_gate parameters to an RCU-protected pointer and
uses prepare-then-swap to avoid races during schedule updates.

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index c1f75f272757..6934df233df5 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c

[ ... ]

> +	if (!list_empty(&newp.entries)) {
> +		list_splice_init(&newp.entries, &p->entries);
> +		p->num_entries = newp.num_entries;
> +	} else if (ret != ACT_P_CREATED) {
> +		struct tcfg_gate_entry *entry, *ne;
> +
> +		list_for_each_entry(entry, &oldp->entries, list) {
> +			ne = kmemdup(entry, sizeof(*ne), GFP_KERNEL);
> +			if (!ne) {
> +				err = -ENOMEM;
> +				goto free_p;
> +			}
> +			INIT_LIST_HEAD(&ne->list);
> +			list_add_tail(&ne->list, &p->entries);
> +		}
> +		p->num_entries = oldp->num_entries;
> +	}

[ ... ]

> +free_p:
> +	kfree(p);

When kmemdup() fails partway through the loop copying entries from
oldp->entries to p->entries, can the entries already added to p->entries
be leaked? The jump to free_p calls kfree(p) but p->entries may contain
allocated entries that are not released first.

The release_entry_list() call at release_new_entries releases newp.entries
rather than p->entries:

> +release_new_entries:
> +	release_entry_list(&newp.entries);

It looks like release_entry_list(&p->entries) should be called before
kfree(p) at the free_p label.

