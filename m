Return-Path: <stable+bounces-268337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KvYGCiYGPWq+vwgAu9opvQ
	(envelope-from <stable+bounces-268337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9A6C4BC1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:42:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oaPH1vz/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268337-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268337-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCF533045B28
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D683D5C2A;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93C378839;
	Thu, 25 Jun 2026 10:42:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384136; cv=none; b=qOUd8hNOWBk+qdtgQ0QEy9DtAzoS4uOGCPMoSqNZFj+qZC2PIw6XNuCu9JV7q9JOQCSr2uMkl3ADapBYYY6BrBu9sJadh6FEnN5IR6oGpKzs489WRJjArFo+mEl7WeYl3RTMzc58uHlmLNcw7U/bAptGHjQ05Th7HOCqOxNelXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384136; c=relaxed/simple;
	bh=nd+/EIfepnNIo5PLnS9kqP0mPMVtpLh+XEgbKruww+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsj7ivpoPnOvR/laSswH/FKxTatZ+7Swc9D9a1+gvwG5WQPrcq8nRYiyySDE7BbBgQ12TmRhcEGE8R0FmNQSNSHqLZIjsGlIPrX07Q/dzpUOipwU8i+JFsWNxFJdT55oPXbfJ9wphICrzqYura5tJWKrZYwBn8HuXfHzS485pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaPH1vz/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D061F00A3A;
	Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384133;
	bh=nd+/EIfepnNIo5PLnS9kqP0mPMVtpLh+XEgbKruww+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oaPH1vz/FlHyDa4xVMnd6XNR4n2mOFsocCXHFj6LHlktoNcphIMlf2NurP6oqqhox
	 cZmtw3vmb4K6fMbG8anblK8XlzxLAw2GYuOxN+Zf6BNNPHRHV7UoM4F0fU3u+j5WGb
	 uJFo/lIG1rlnN8bZOY4jidmRnptl185c00XEUfpoEDzQHi6Zc/gxPOvdHf9sZxYbif
	 REkm9/BbRreD2laLjG6QjChTgesy/Qz9NeOeDD/vDFmLXdDwT4u7hsiFCqfP5+XVfC
	 Ul9zReYKQoktkAPG6BnsV9bFrxf2o9ciC8HLG9r2tUepC7wZ79yEVwSwEosSVrQdpu
	 tG+FeDT887a0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>,
	Lee Jones <lee@kernel.org>,
	Rao Shoaib <rao.shoaib@oracle.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: Re: [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Thu, 25 Jun 2026 06:41:54 -0400
Message-ID: <20260625054005.0007.afunix-siocatmark@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624151651.38894-1-alexevgmart@gmail.com>
References: <20260624151651.38894-1-alexevgmart@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268337-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:alexevgmart@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:jannh@google.com,m:lee@kernel.org,m:rao.shoaib@oracle.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:wangjiexun2025@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,redhat.com,google.com,oracle.com,vger.kernel.org,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
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
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5E9A6C4BC1

> [PATCH 5.15/6.1/6.6] af_unix: Reject SIOCATMARK on non-stream sockets
>
> Backport fix for CVE-2026-52928. Reject SIOCATMARK in unix_ioctl()
> for non-stream sockets.

Queued for 6.6, 6.1 and 5.15, thanks!

--
Thanks,
Sasha

