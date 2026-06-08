Return-Path: <stable+bounces-261940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FWukHDgOJmpaRwIAu9opvQ
	(envelope-from <stable+bounces-261940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:35:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E2D65204E
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 02:35:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cNlz7XJS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261940-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261940-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A073008504
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 00:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239902DF13F;
	Mon,  8 Jun 2026 00:34:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8762D3A69;
	Mon,  8 Jun 2026 00:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780878898; cv=none; b=AivhuATMkhQvJUiFLX5bq4Ek0PYsqR0h82l8seQVzhnAfrhcQGgyPsu1lGFWqKTCslWQjSnNIF+9E7VMeSJgC2PH+s1XL//r4aklExkThDdFttyHSbhcmN7JM0sZJF8noAsVd2nqYs72dLm76h/NT64k3cMsfIof40ZGameyP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780878898; c=relaxed/simple;
	bh=gJqfnk+Di60N+JgxGVmq/KV2VfxeZ7qDIQnDXTkPdTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw6sdjpRiits6/Hci3HOVIVSxzVVcPX0pz0cObOjaB5ZRPMxN7i1s27yONnPtf0hg0gm2PiQLW/qxunUbxBmlZbbtKVrOW/s5/BMFb/Fk623GquNby6x7/1jBKu/KqGHaS2GAmkEfhxQqGdzBse/u2xUDamX2YyAVFg9cG2KRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNlz7XJS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D94A1F00898;
	Mon,  8 Jun 2026 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780878897;
	bh=gJqfnk+Di60N+JgxGVmq/KV2VfxeZ7qDIQnDXTkPdTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNlz7XJSfkY5yyY9pTgZW22K8WcbeoQU1dZPXEq/mmYHwV7Tb0f+70u14fJlonJkc
	 mMkAyfBK/0ZX8S2HQjP+elmgnBDqd6DmZtm1FKgHcULSTQPvSxhuozPl9epyLgThXm
	 Br3rOw94mRgv+4k4sHyJvsN+znXuAzV2C4xdnOAaygdP99fRk1Ad2YxdbgO/uGP6f7
	 2g6HZzgoTk9dlR8DQ1Yn+mQdmCHDNXd9Qyi1aRKFXOJd+2jnUFRt87hcgwbe97Epp4
	 0zLDPfDnz9lZLT6TV6s/qtuK4qVdEjJuV0ZA/9ohRIOREnB1Nx0LKuM+wYePgdVTGI
	 2UIVGEktbmrUA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@suse.com>,
	Ben Segall <bsegall@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Liam Howlett <liam@infradead.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 7.0 015/332] kernel/fork: validate exit_signal in kernel_clone()
Date: Sun,  7 Jun 2026 20:34:49 -0400
Message-ID: <20260607202000.rc-0005-fork@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aiVOEKt9QL5cvkwz@redhat.com>
References: <20260607095728.031258202@linuxfoundation.org> <20260607095728.598854921@linuxfoundation.org> <aiVOEKt9QL5cvkwz@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261940-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:Kartikey406@gmail.com,m:syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,m:mhocko@suse.com,m:bsegall@google.com,m:brauner@kernel.org,m:david@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:kees@kernel.org,m:liam@infradead.org,m:ljs@kernel.org,m:mgorman@suse.de,m:rppt@kernel.org,m:peterz@infradead.org,m:rostedt@goodmis.org,m:surenb@google.com,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:penguin-kernel@i-love.sakura.ne.jp,m:akpm@linux-foundation.org,m:oleg@redhat.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com,suse.com,google.com,arm.com,redhat.com,infradead.org,suse.de,goodmis.org,linaro.org,i-love.sakura.ne.jp,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bbe6b99feefc3a0842de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13E2D65204E

> I don't think this is the -stable material.

Dropped, thanks.

--
Thanks,
Sasha

