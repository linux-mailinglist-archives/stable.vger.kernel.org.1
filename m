Return-Path: <stable+bounces-269257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OUZSAWW9PmoELAkAu9opvQ
	(envelope-from <stable+bounces-269257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048676CF846
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GKMuQPYl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269257-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269257-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8BB30C8119
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0723A7F70;
	Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A63A875E;
	Fri, 26 Jun 2026 17:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496491; cv=none; b=dKfjWC/xSUXEZBvVNO8vNwXhQt4wWJlqs0FScYnQ92KkyySr4fdvF8pby1nI+bFIKtvNcwqMZBkqxT7SQvTj9q0D7Z7/3DVWVozDp+NzesrchBhDFMW4ccqoHcPS2s3M7rQgt+zE9IPvOGpTXeuXUcYudwCgyZ7XM376Y/Rzf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496491; c=relaxed/simple;
	bh=dIdnGL6IvbkcbDiXHYQqD/Ev/2LQPtDuUZ7rfkWmnM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBc6ISN5Rw2ZmyIeU/77gLXJab3vwyCrzQ+M6sJPy33Cf95VKvm3dslFcX9VnX9pM74/gGnjmfL09u4jt57rVapNtAuM1EpaSwfz/GuokLGCgNi1ptDKA4qBXJ5lToRsWFSy3LuAbqHcsVbCimQy5FQyjmZ4Qy+zFjAufBzc0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKMuQPYl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859431F00A3F;
	Fri, 26 Jun 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496490;
	bh=9UZVX0Z6Eb9Ku3XBO729YO5s0eNrnrNTp3rE7j4neMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKMuQPYlO4FrmwrJS7Fe+7JSgIgyzAbSIZ3cyUeFJAkRP9DN6TsOTR785YDRMr9Zz
	 inuUqivywKHnt6/DsitTIMd0ShSfVOtVlaEgBfdupLXkEmVg10qD4eTmLrAVyc5s7y
	 /gYtuNSmn/qHRVRb1GuJKfChMOipIFQHqhg8fiPDo/RMsixlMAZIRY1ZCKniZhAb1v
	 bWN1LagBqtlOgPZY7Z6873fYcB0NNRySkAfuoIdBol7WhUjhGowzOwuOSq4OMbSGi9
	 XeZt99qDG165oGdNroyJ5t5fSmJSR7oRYq3ozLk0ZIXG3izdq0tInKY/zXU/4XatZ4
	 XvwAtLGj83PJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:21 -0400
Message-ID: <stable-reply-item006-role-618-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112315.1777138-1-pbonzini@redhat.com>
References: <20260626112315.1777138-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269257-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 048676CF846

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.18, thanks.

-- 
Thanks,
Sasha

