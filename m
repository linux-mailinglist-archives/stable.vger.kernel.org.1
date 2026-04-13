Return-Path: <stable+bounces-237673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAL0A4tw3WkgeQkAu9opvQ
	(envelope-from <stable+bounces-237673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:39:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB73F3F56
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D0403030993
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0936605A;
	Mon, 13 Apr 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaRDsY1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0366A314D1F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119658; cv=none; b=BjX6ASvMvvMyQ0Ay7N7KBaxSuObdsvNBIBmmLmI0z8+rw7mHJ2F9+5krf9GzDhnf3fGZOpiC5WNYN9idfpZD9llfQs9JnZk7NKreQabZv2e2eKkiTzTB3KETeVAvxDfGJqOD0M/Wx47VAXH0tGPNGrF3QTCEIc9gqP9yY63+rd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119658; c=relaxed/simple;
	bh=IVUwwL/RbmLrwCd6eKez2t113y1xA1ZR20/bBNEwx8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGJ9ohUSkBqfnQlZzm7CX5v6nQS1j0EK7DwjNQLEpwnl5yK+NMQO3vtQ6sqvbSgOrzEL9hOwTSd0mOk1xz+Pcv5noevdjNsEFcNPOeEGpYWe6ORk/hJah/iMmBxJ1UUp5QsHvRXTpneMj8RF8qg4aN/m+PxJ3g0Qe0aVRy8UZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaRDsY1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DECC2BCAF;
	Mon, 13 Apr 2026 22:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119657;
	bh=IVUwwL/RbmLrwCd6eKez2t113y1xA1ZR20/bBNEwx8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaRDsY1BlPh8+cA32lGSVZ0dw26oJs3FG7A/ob7DGrIjMvMvKl7LZoIjxW6wszwnQ
	 jyahe+cGzIKjn9t8ldmvYiPlKrXJDqVpubW3IHQr0LLiZpAHHuTED4nfMVbBxAjzF4
	 vItXQF/j4PIRHL61aa28H+Jql4eVNQp9zljZYTtrFJ3JaJfNL+K/8R6HrB6EshDYc4
	 VhR0N5HmTd1p/Bh8951cBTHSAzmt7DjYd+5/hoDW5cTrOML9TBIgYe7GE7LcXtmZ6j
	 RzVC717/x6uPoELz+23pjUhnt0EBLhYmSqXknPseSh6z3pHGQ/bmAl3zdIh5kJMLBa
	 UeVVdRLrEUs/w==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH 5.10 419/491] mm/hugetlb: make detecting shared pte more reliable
Date: Mon, 13 Apr 2026 18:34:16 -0400
Message-ID: <20260413223416.3761317-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d23195793d7f1cec4c8ea1b1a5e29fb6051211ef.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155834.712660018@linuxfoundation.org> <d23195793d7f1cec4c8ea1b1a5e29fb6051211ef.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237673-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2CB73F3F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-13 at 22:12 +0200, Ben Hutchings wrote:
> Missing "commit 3aa4ed8040e1535d95c03cef8b52cf11bf0d8546 upstream."

Added the missing "commit XXX upstream." lines to this patch and the
other 4 patches in the hugetlb/rmap backport series, thanks.

