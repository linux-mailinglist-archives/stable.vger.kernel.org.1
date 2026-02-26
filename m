Return-Path: <stable+bounces-219846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKK3C9igoGlVlAQAu9opvQ
	(envelope-from <stable+bounces-219846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:36:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CE1AE708
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E3FD316D453
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C5444B69B;
	Thu, 26 Feb 2026 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6/7P8Ty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627C39282E;
	Thu, 26 Feb 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134213; cv=none; b=iQi2/ACXfixeHWYL4RsF29l4iCX9N3zBbR6RVbRIj4c+JhcKHhnt8d5CZjbxiIbup9hfeoIrQBb7110kJYSxMm1QDEx9tc3iUL4+NK6KK3O5LpO9VVIs5gKEy2AmE+DttHPsnCvbUB8kgphTtwu49vVKXCyYz9PcsVnQp3P2Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134213; c=relaxed/simple;
	bh=Af0wSbqgxlFhesc7Ld7NDa+d2MCVqtDYKuJGYiHKgwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y16Tg7STdQDUL5AW69PQPW3jAn8i2QcnVWdkFUvD3iTLpVUry/GrmSTv6Rook5ZiqRZ9PiaLqZ6VQLxcnNHl5bhP3LeqO5aAEg5rmrxdK65Xa9dueCHBh/mg0y+ExWlGND2AIOpdpCyVxrr8o83M1dgy8g9wGz9jJtoWpMWwei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6/7P8Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7592BC116C6;
	Thu, 26 Feb 2026 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134212;
	bh=Af0wSbqgxlFhesc7Ld7NDa+d2MCVqtDYKuJGYiHKgwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n6/7P8TyPtMVIoiMsVjQh5Aph01ILAsET7FWtw1uKi6wY90IgSqntQJoPJWvUvgQz
	 6eIW5nOA3/VwMr5nWVFd8DHd7oVJemKgd86xXuGY5d860zL6Le+17HVTX+oByW7ecN
	 Y+3iira39QdhOC6lWpYLJweQyWnT21IbZL+MXx3JsGfegxTIophocQRF5BR5CYcYMi
	 w0xgJPtHmvo/t9LEialgncgNH39Qlo25r5AqjjUpVkwyA1xIlbEU4hr8sj9F7iuCUi
	 qS4vOsOZFEuqvWM2qV3YxrM+RwW4lTvQXPyBTiHnqcPK12KtJ9dB03Q3QKGEgRBKAk
	 5WLZdy8CK0z7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D653931090;
	Thu, 26 Feb 2026 19:30:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix kprobe_multi cookies access in show_fdinfo
 callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177213421655.1808439.14823705396024215144.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 19:30:16 +0000
References: <20260225111249.186230-1-jolsa@kernel.org>
In-Reply-To: <20260225111249.186230-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 stable@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,vger.kernel.org,fb.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219846-lists,stable=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 782CE1AE708
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 12:12:49 +0100 you wrote:
> We don't check if cookies are available on the kprobe_multi link
> before accessing them in show_fdinfo callback, we should.
> 
> Cc: stable@vger.kernel.org
> Fixes: da7e9c0a7fbc ("bpf: Add show_fdinfo for kprobe_multi")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix kprobe_multi cookies access in show_fdinfo callback
    https://git.kernel.org/bpf/bpf/c/ad6fface76da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



