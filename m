Return-Path: <stable+bounces-233837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAlmDnAz1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8843BAF46
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8097B3026607
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E23BAD83;
	Wed,  8 Apr 2026 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttP6Mkwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D834DB6B
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645535; cv=none; b=R7pUrvcjRqjU4cbs0mdkYUTgEMm8KY6TDiSVS9JglS6TZGby7JvdwSef/FmaK9QvQTEsekTcD1laNpjyp/fJZOHRzLP/SLTIWbbO2m/9TOSbbzTE2eN9Ua7EVMQFYPQe1b+9qh5LYCy+9BcK3w0hfYXPiPS9LQQWnsCzwWUQdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645535; c=relaxed/simple;
	bh=/SNbPteDZor1dsVRxVu/DYC1k0JppUgnlakO33eSvKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJQHQkwDV0ogi/lewTEPVQIXSqEujFUESep5yd8FVeHgS16KXBrr8NaPCM3AllnAXogWDfFFN5cMb4Wk4EbiI/zP7OvvechBSHoOLg9Jkk3rWkcSd33BwagYhxmcL5YOrhI8Fmho6TW/glZH60ZU8LB8P72NDnyUbmTe07AYJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttP6Mkwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321C1C2BCAF;
	Wed,  8 Apr 2026 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645535;
	bh=/SNbPteDZor1dsVRxVu/DYC1k0JppUgnlakO33eSvKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ttP6MkwanPJyeTIFWEB8QPtDwJyLuaKP3TuQWFU9GDhZusWYXIiM7l8GAjZ3fhBBA
	 FigM68W0rwkGgAot1qmajfGdecO+eI78p+hzCnePJsqM+zTI0BXY3ns0uUQnEMWOyN
	 xjZlwaqLZnPf/NZlyDXVwmUu3RBvNtkHVFY0GM2w6J3a7WqSJbEu+Yvj+0FEbuCJsz
	 NKpPhg4nezGw1MpNr8aNRTDgRu022GBXa1kC+iWOyTcO600sl94DtZ/wL8duIZgacE
	 ac7SCkCvx4MsXFDuWIMWbh3NwNdGPA+ds3Dz/go+3U2HCrNjsANhZP8LXp6FBpfhiX
	 gDi54zpzJ6vkQ==
From: Sasha Levin <sashal@kernel.org>
To: Ruohan Lan <ruohanlan@aliyun.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2 1/3] can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak
Date: Wed,  8 Apr 2026 06:52:13 -0400
Message-ID: <20260408105213.946738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403013615.4641-1-ruohanlan@aliyun.com>
References: <20260403013615.4641-1-ruohanlan@aliyun.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[aliyun.com];
	TAGGED_FROM(0.00)[bounces-233837-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E8843BAF46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

All 3 patches queued for 5.15, thanks.

