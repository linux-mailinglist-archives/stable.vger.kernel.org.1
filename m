Return-Path: <stable+bounces-235899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKl5H9Fv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B33E7426
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43C0E304D1CA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B5382F2F;
	Mon, 13 Apr 2026 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqR10j/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E938F95A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053641; cv=none; b=dn5q8HbMcMBg9NSxvckQrkDu0XnFioTeK1vd7AAZRIBrrnkKPvjJhCrvxhe+t8PBrguiOoMbQ7I9lw7Em2pl9L9D3jqmwaNBrftFOmhmffnMyrnbQia2laT50BWRt4NAR9ViKRRO/Msh2Y0Bq5SjR3dIlD36Dtmq9mDP6Xyz0Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053641; c=relaxed/simple;
	bh=uK8honG3OBDLMdZHd2JUR1Zx7btDUb2+XYRjZmz/wfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5ZamzSkOg8WDByawgO4U7lD+hW92DI1s4juho092g+jbpi4HuIr6Sr2Vj065Rgj7CDnVeiCx2gD9wKpHOxhZ/AIaADhowo8EG/D8IW18Drt5Muv/4Le6bZU33K9/eu+xE+3mqHqWkeJwE1MiaArBMDKlBEfY7g8RrlgxSOQeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqR10j/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A8FC2BCB0;
	Mon, 13 Apr 2026 04:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053641;
	bh=uK8honG3OBDLMdZHd2JUR1Zx7btDUb2+XYRjZmz/wfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CqR10j/MaHXP1GpzCYfpjjo96N7Wj6t/Aa00XeTGb7yv+wX7eEUzt7rnZqUANxkpG
	 m+nRxp5PKo9/fUg3J/3iyZZGN0shsNZXlw8ok2r9AiNC5yvtIdS0kD3Qn0uEWgniRK
	 IjMeUiqR9ablgY2YL+BXQc+CyiOLLXgR2PaWxXIlnSumdQLyJS1G+nyOF8Hi9opg5j
	 ehcZ0XW9fPFThVNh3MqIOsJWUt0u1LxfxYdmHN51DQvJC1N2qScu6+uscQvLcmVn3W
	 QoW5SGs3l0dymVYCAKQjC+VI2yGuAfXiserF1aZod1S8m8ozB7AEW1CAqF7kzLxC6h
	 mRw8xdY9341DA==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.6.y] scsi: ufs: core: Fix use-after free in init error and remove paths
Date: Mon, 13 Apr 2026 00:13:59 -0400
Message-ID: <20260412120103.scsi-ufs-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060147.3175811-1-rob_garcia@163.com>
References: <20260409060147.3175811-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235899-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 420B33E7426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.6.y] scsi: ufs: core: Fix use-after free in init error
> and remove paths

Queued for 6.6, thanks.

