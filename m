Return-Path: <stable+bounces-220071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFMgMbkDo2kJ8wQAu9opvQ
	(envelope-from <stable+bounces-220071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 16:03:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CC71C3C93
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DF23109656
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB344CAC8;
	Sat, 28 Feb 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W56Lrb+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF0449EB3;
	Sat, 28 Feb 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290734; cv=none; b=srWrRVfXsQLYwVMgr5mx5T87tSnH06wuvZm6eR1IFzC/vmOH5NbyKoRFBRIhgPyUrwnF8C118iQagno3BFY8kckb3+uh+3Z2EsDKHNjK4KfY0SapqV3rsGUXC39cPHIgbgnzuy6TWIRDzFxYcjr8HoOCtk5I3+4V3Rfuhl/nq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290734; c=relaxed/simple;
	bh=0OyJcWNteWiTO58j6Le8ba8Qir8zEk0kOYFEoDW4tXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FXHbHgNOBufd0aRO+r/EWJ0gx78Uzk8ilidpZv3x2Z/FqHcujLGFHqN7IbHJsbleDmhMDQdgJSJ/FofapFFOqxgUVk15391/DOumpEl1HE606lAzK+FfoGCGQgWOYyN6x7qcorZ4Lfmrut7CqN7LG4dgwZ/wASil1AyGQFqShTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W56Lrb+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE81C19421;
	Sat, 28 Feb 2026 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772290734;
	bh=0OyJcWNteWiTO58j6Le8ba8Qir8zEk0kOYFEoDW4tXk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W56Lrb+47NZ+p+mBAUphKa58Oxz8ePjhF0kTbndR+xz0Vy3I6WAlMjicTc/GmLIPv
	 99F6qwsxRi4WUzzTFlfzQDJlioC6/dApQj9gpL6TPZcVWOFeduSty3Y22bpBzLokCO
	 YRXfO7lRoKJnODF8DaIb4M/89rt+e8WjTtjqb5TFIq9U9qLi9onishF/VMGeJ3wjB9
	 rnNdXz3x0l0ReLau2+rV4M0mRxaPUa5F+ZCjMqLkknAKvly43cCvrsfmwhGzS/8CWR
	 08d8T2kt7EfiRrmM75cuimPxPbHDDrofMZk3z35kndaglOVunQckq4eXmFCKjLFYo+
	 NkiyUN3NlUZTQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2] firmware: exynos-acpm: Drop fake 'const' on handle
 pointer
Message-Id: <177229073130.58647.11987139126675596860.b4-ty@kernel.org>
Date: Sat, 28 Feb 2026 15:58:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220071-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63CC71C3C93
X-Rspamd-Action: no action


On Tue, 24 Feb 2026 11:42:04 +0100, Krzysztof Kozlowski wrote:
> All the functions operating on the 'handle' pointer are claiming it is a
> pointer to const thus they should not modify the handle.  In fact that's
> a false statement, because first thing these functions do is drop the
> cast to const with container_of:
> 
>   struct acpm_info *acpm = handle_to_acpm_info(handle);
> 
> [...]

Applied, thanks!

[1/1] firmware: exynos-acpm: Drop fake 'const' on handle pointer
      https://git.kernel.org/krzk/linux/c/a2be37eedb52ea26938fa4cc9de1ff84963c57ad

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


