Return-Path: <stable+bounces-235851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLzdNPr922luKgkAu9opvQ
	(envelope-from <stable+bounces-235851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:18:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5E43E5D93
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 22:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 950EE300CBFD
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D837F01A;
	Sun, 12 Apr 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooUifqCP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55212364028;
	Sun, 12 Apr 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025073; cv=none; b=eimkVsiVGEV98ryefWMNDE5Y3D7qe/2TGDX7K3oaJOjpXioZxRn67M/AFplCbtFEcHrJ4Lo4s/Sh/ixLW/ER9jbqb9erRal4wEF9tFii+q4fhdTRz9aJJfaWETNuY/UOw7NBeZE256+21ffzfkUZQkDorPXq2LPsx1xDfUQwqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025073; c=relaxed/simple;
	bh=+GQ2w14XZKFOtmHTRbBaPgP6q1+SXe9xjwyp5/qjVzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5w5aQ7NB6FFm5Ll7aKFTuWUQ8Z9dUFVJefc+lbGGID3aDVuye8ygnZa84WL3MLHdqwo0tXBdAu6FmzyMiqYPZSR9n7idoIqvn/O0vaH7ShyFXeDHdWs9ep2jIJh4x37UYvfmon6/KO6yWbPCatuif5HHLhH2Glab9NREwL4HME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooUifqCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AAAC19424;
	Sun, 12 Apr 2026 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025073;
	bh=+GQ2w14XZKFOtmHTRbBaPgP6q1+SXe9xjwyp5/qjVzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooUifqCPoVPQ4RAl4uE1Go3evrVTnRZ+OrSXMGEvOdabVYx7YKdbkuwrVE7b/CrWv
	 /4d+fbV3g53P0UqcW8EIgWbDSoVssmgGaoFtec42HGEk7Ih17mr48a3cPH1UVtbe7L
	 GX9LbDZcP86dzHnBrE2Ttm6S/zKhjF8FXfvENlL3lHgtN0X1lE5iDMLFR/C+bgCNKZ
	 HtzCNbp5AjXhVuo9G+gAA0HM6UZcvysb7MCGgmChscyEqdiv0//HDBi5Q65l9pzTHm
	 mxyvVNyKOhVK5/UpAfzP2lINlmoAAGGgp/u6Ao1RdrqNF5nn+8ytMMF+P1iVxo8gDv
	 KROYlGRHOA9VA==
Date: Sun, 12 Apr 2026 13:17:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jreuter@yaina.de,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
Message-ID: <20260412131751.0e90a053@kernel.org>
In-Reply-To: <20260409025026.24575-1-mashiro.chen@mailbox.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-235851-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B5E43E5D93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 10:50:26 +0800 Mashiro Chen wrote:
> Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
> overflow before adding skb->len to fraglen, and abort fragment
> reassembly cleanly if the limit would be exceeded.

Same problem as reported by Simon on the netrom patch applies here.

nit: I don't think you need to cast ax25->fraglen to unsigned int
in the comparison. since it's added with skb->len it should get
auto-prompted to unsigned int.
-- 
pw-bot: cr

