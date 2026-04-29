Return-Path: <stable+bounces-241939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eP7gDPpl8mkBqwEAu9opvQ
	(envelope-from <stable+bounces-241939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:11:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A969149A00D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8566C302307C
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 20:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C8838550A;
	Wed, 29 Apr 2026 20:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I59SNJlE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91DC28CF77;
	Wed, 29 Apr 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493494; cv=none; b=CbYiamRKmPTXVBFoiCQ2p54vNxUJSZulgWLF+fxrphnXP/3BsFO7k7pg7HUWCKwSay09pZQ/iA1xuTcT3ErThcMb993Rbp3yuSssTvPYJITfyZXzescBu26ojvL5ssys7P6Hn1Hk5iOCi6hrvK49fw0yVl/lJwJyDcAKa+xWlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493494; c=relaxed/simple;
	bh=b/K0zCkxJbLMhVPvdWi1PFTRpDDSDat3DROdGTL7MJg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=RybmElFEd1WAM58EGJx4JzjRJ2rFAEu6uh3xmsrNb3gudEUDC4MGngwVwxiA3h+v05uSgWUpabYVsx7mi9ThTeW+GQSrlsWSBQAKGZTbXJqCA5TSQ6DxCV5BZn2y8E8Oqwn+bEwpUt5iSwwI9zHk/OcPuWZW572cytUYoBSvjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I59SNJlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C931C19425;
	Wed, 29 Apr 2026 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777493494;
	bh=b/K0zCkxJbLMhVPvdWi1PFTRpDDSDat3DROdGTL7MJg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=I59SNJlEdkc0zhL6p3ieowt9AJGTAKUX2UDRqvbmbr0mUbWlq/uMlFUYT3AAifEd/
	 wtRC3J24zGSSUSvDwEo9ubj2DrEu69pE110o0/iZpyypzWdg0GTvDIC3DyGxXYBRQt
	 cPkOcPTLDXs9hJZRb8h42Ibq2cFEmeBXBhFu4DnGLzYmVLWAPH3smLGKpI11Dk4pdN
	 TLyuUzktAh0oB4Ns2v9UKDWwGDTIKf22tqrwHp0wbAihV+8STu0b+w5uxRLc7q2ieq
	 UOpGYyqUheROZMwbi7+XteRjAQwNzExQ90hotKbQTmcaZzJAKz7htj8J9VCatLfPpf
	 yXs6mxBT5GRNw==
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 22:11:31 +0200
Message-Id: <DI5WUT6CUDAN.3SI10HVHF3NWJ@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
 <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
 <afHapCZz5C42euaD@hovoldconsulting.com>
 <DI5KV97TNS9D.28EQTYL46PKT1@kernel.org>
 <afHpUxQ5U_4RWjDZ@hovoldconsulting.com>
 <DI5PDWIV7N7X.16VB7OPUTJ6ZK@kernel.org>
 <afIdl9VcaXxBb0Ll@hovoldconsulting.com>
In-Reply-To: <afIdl9VcaXxBb0Ll@hovoldconsulting.com>
X-Rspamd-Queue-Id: A969149A00D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241939-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed Apr 29, 2026 at 5:02 PM CEST, Johan Hovold wrote:
> Again, feel free to drop the CC stable tag if you want to.

It's not so much about what I want -- I just try to stay close to what the
guideline is, and only deviate when there's a good reason.

