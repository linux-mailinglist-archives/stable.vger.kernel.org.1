Return-Path: <stable+bounces-240505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FicAy0u6mmfwQIAu9opvQ
	(envelope-from <stable+bounces-240505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:35:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734C453C61
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 16:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4D9302FA80
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DB433F5B6;
	Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHgrC8ZA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3433D6C0
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954510; cv=none; b=hpueGl1a84eyR638yLzflW/SvizHzzDO2R3Luzo7/58NJfTfciOb9PdLTqrlVbRxPWqaBtKEbujuEeNX9QPRuZkaQU6yNJjRIpd2dzCCszbQD99Fif5IirGstyUdj/fGxhjkQezH5NBir0hOmvOny9wRl0yA87UJ13nqdHATJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954510; c=relaxed/simple;
	bh=2UQ6osrqpC78k+sK+vjouush46yvF77J8aZkIJ6Tqn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdgkqKFSxqCV+lUDMYdYQWMUACXb3eNnZ/3yoji/abBfqsEFtRfB+2rFo39BvplTit5EwYzFy49JAhEFVJhTSv1XefPhJM9VJQb5OFt5BeVOVoTI2+FLHn1ZwWPWga2+O0im2sIrsmpaON4UUM/azspZAPp2KqtyDh921h7j5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHgrC8ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ECEC2BCB3;
	Thu, 23 Apr 2026 14:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954510;
	bh=2UQ6osrqpC78k+sK+vjouush46yvF77J8aZkIJ6Tqn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHgrC8ZAjdYHMyDTum2RG0k+NpY7gOQNGZlxdRgcnEDWNONt/EnDoORxRXqxF8IZr
	 lgp0vG6eFRjP8+mcv6G4MBH4v3qWB6JVB0aoinYukopId3g5Qbn+7Bce/O46rnafy1
	 X5b0vB6Wj+dVYzHbmQtd/uL73smxmiY3wJmqzJUOANjwoRDqBCWmnFO8u88Jv/8Gbf
	 uFZxAzxdfrpO0cl32BvLMmzoogshJxbzPKqjTN1EJcxJbUFMx6/ILCeys5vbSoLTJw
	 fN7j8X/H5fujm/f7Lx3Vebyl33aFxeP/QmEuskvuq6aF89UV8A3xiSHe+3xZuIs2Ly
	 5sI9YiqkiL2LQ==
From: Sasha Levin <sashal@kernel.org>
To: Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: Re: [PATCH 5.10.y] scsi: ufs: core: Improve SCSI abort handling
Date: Thu, 23 Apr 2026 10:28:22 -0400
Message-ID: <20260423143000.item001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9ffc6bb5-927c-2729-71f1-10180e826ccc@basealt.ru>
References: <20260421131941.38176-1-kovalev@altlinux.org> <9ffc6bb5-927c-2729-71f1-10180e826ccc@basealt.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240505-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9734C453C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 11:12:04AM +0300, Vasiliy Kovalev wrote:
> Please drop this backport from the 5.10 queue — it is not needed.
>
> After review feedback from Fedor Pchelkin, we verified that 5.10 is not
> affected by this bug. The upstream commit 3ff1f6b6ba6f carries an
> incorrect Fixes tag [...] The actual regression was introduced by
> 64180742605f ("scsi: ufs: Fix the SCSI abort handler") [v5.15-rc1],
> which is not present in 5.10.

Dropped from the 5.10 queue, thanks for the heads-up and the detailed
analysis.

--
Thanks,
Sasha

