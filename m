Return-Path: <stable+bounces-238883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ot9Ggk15mkGtgEAu9opvQ
	(envelope-from <stable+bounces-238883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEDF42CD11
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830A032041FF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70FC3AD503;
	Mon, 20 Apr 2026 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlU7hxIp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04B3ACF02;
	Mon, 20 Apr 2026 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691295; cv=none; b=s3Z62KHSnfgLavdpyfsyP1eBEgyqlGEWrS0ReMrVhuj8iIW2UJUKFctAcvdzyGjwg/5zohLv6vpWZB6FTFEc8NLtlFtI7JVhBA18ZHl27gdr4VgbS7yyhrDMOMzT9n4IXMAp2medQfN6sLnby6AIVPCELmKE/wGO+u4ROB2jTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691295; c=relaxed/simple;
	bh=V2yOr3QNHt5MBchGQMWnRN1XPL9cp8vEXRrAzn5rTHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3nUfppvsCRD9APoXFhgC7uRPNJb2UPFQZ/F3ThP4OnZ0O99ERC1JCHctvSIYPqrgtLkH3fq43ytPfA3imQ9gY0+Kp9G42XoHzpkCw5lG4zfOD12/p7Nd6/Nq+fEs1ypVKnGRl34eDdX+ZBgMoNuqBe3ZpMC4ON9XYr6kWLJJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlU7hxIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE98C19425;
	Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691295;
	bh=V2yOr3QNHt5MBchGQMWnRN1XPL9cp8vEXRrAzn5rTHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlU7hxIpALzp6Ae78nHYTmqB9Q3IA254w0aAWNaDZtdkzJfca4yd7KFUZesVGQ+Mr
	 TWhPORDY455JmbbrAKGs3CAHQMQLYRPPhAs6TggTPDb2gB+LMscJ2gEsuROYjZBuri
	 cTIu9OvJD7fqb7WMR2S7dakY0lhxfS6UJcvj0RYhQU1qMJx6v5lNbcUidDaltguUbo
	 hvHedXMPqikribXCVkeyGH5q8XHMMdmjrSurAt6o5B/Kh0vYymZjkThQH1+3adE/K4
	 6cCPyy5jUQ/RsZiF2c/PH3gjjfMdOuoa+1gIMwjSYWzy7sT1vXcLNEX5VRUQ9c2q4g
	 0P47Hu7GJRVLw==
From: Sasha Levin <sashal@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: scsi: core: Move two statements (prerequisite for already-backported 4ce7ada40c00)
Date: Mon, 20 Apr 2026 09:21:17 -0400
Message-ID: <20260420-stable-reply-scsi-21008cabc5d9@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ed7ab018-9a77-4e8f-8480-cdd92c4758c5@oracle.com>
References: <ed7ab018-9a77-4e8f-8480-cdd92c4758c5@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238883-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAEDF42CD11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 14, 2026, Harshit Mogalapalli wrote:
> 21008cabc5d9 ("scsi: core: Move two statements") is a prerequisite
> for the already-backported 4ce7ada40c00 and should land on
> 6.18/6.12/6.6/6.1 (and 5.15).

I tried queuing 21008cabc5d9 on 6.12 but it causes a build break: the
prerequisite ed638918f4df ("scsi: Rename .slave_alloc() and
.slave_destroy()") renames the scsi_host_template fields
(.slave_alloc -> .sdev_init, .slave_destroy -> .sdev_destroy) while
drivers/staging/rts5208/rtsx.c still uses the old names and fails to
build with:

  error: 'const struct scsi_host_template' has no member named
  'slave_alloc'

The same rts5208 driver exists on 6.6/6.1/5.15 so those trees hit the
same wall.

--
Thanks,
Sasha

