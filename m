Return-Path: <stable+bounces-233736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIyED+p1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC4E3B5D2F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 03:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12EAE3012201
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2B327BFA;
	Wed,  8 Apr 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAWn9qmN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489943290C9
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775610136; cv=none; b=mcA6bSxsWJ8DJWO278Iv22dujG8rD6Yjs9qhiELIjs2ySJITE86G9EMhKKJzWu94SLnjc95JKsCzADN4j/bcAdUM+2y4KwPhf8W8hsspJlFZF19deeEaed5R3Hi0uECLOsChU+QQt8DfPScx52VG3lbYep0Pnfh+Oefb4lNcVkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775610136; c=relaxed/simple;
	bh=Gir0YwO0+oP3sxh/hLqunSafIo+6+Ug17p0Ek3bbwmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnwBfnG6alCzKkHBS8oXlubI5UddShKnQkRH6xjvNE3nizAhJJAedt9S9XUAHyXWA4F6ZypvN7TYA691lZ3volw7heerr0I0rF/DJri8y/xVp8lfXsTGflayGeIvztigmrq5uk4EMrbE6C2BmB8oG+vGS99BJkubGVYnkp6ZMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAWn9qmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F02C2BC9E;
	Wed,  8 Apr 2026 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775610135;
	bh=Gir0YwO0+oP3sxh/hLqunSafIo+6+Ug17p0Ek3bbwmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAWn9qmNOLsUsHSIE6BFlimRKzSfs89ESvqgrRfYgwJZgrq65nWqEcpmwfLntQZDS
	 HETH48+PW/VgW5LxaoC/UrdjKUm9diuYhmbYIfYsrxV8NffeyQ9xHKXs0MpiDopYhl
	 CBkCivBTcf/CrXFIGipUt0A6Pckx2QkSEuXXtTNiCyRN8IpOZdUDDRSVn26Kz1YqsN
	 AQWSuc6eRUHvOL1KO9G27fjiHbIIjH1S4Jc2atPyljILBr/a+jmCE9EzxFUzlEfm6t
	 TAE70jjZrXY6Q4lBW/WY0BvVoSqiSkCt/b0MeV1AxH80msKKjui6YuVJLgsy8nk0Qk
	 xUeBYL+bPILCw==
From: Sasha Levin <sashal@kernel.org>
To: Tugrul Kukul <tugrul.kukul@est.tech>
Cc: Alex Williamson <alex@shazbot.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y 0/4] Fix CVE-2024-27022: fork/hugetlb race with vfio prerequisites
Date: Tue,  7 Apr 2026 21:02:14 -0400
Message-ID: <20260408010214.746262-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233736-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAC4E3B5D2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:13:07PM +0200, tugrul.kukul@est.tech wrote:
> This series fixes CVE-2024-27022 on 6.6 stable by first backporting the
> necessary vfio refactoring, then applying the fork fix.

Queued for 6.6, thanks for the thorough work on this.

-- Sasha

