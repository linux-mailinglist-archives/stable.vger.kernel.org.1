Return-Path: <stable+bounces-238437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HS7Kbfg4WkKzgAAu9opvQ
	(envelope-from <stable+bounces-238437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B9417E44
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E67983014A12
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D037338936;
	Fri, 17 Apr 2026 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfRkGkcc"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD2A3346B4
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776410800; cv=none; b=SZVJkMqU8oNSHsGgCuCX25dAH0NMo9+BSKwyqKyXf7kg/hyg08/yN9lfEhvCzy58ayqGSX0P19inwW+ZvbX1d6Ek5iB5WA++V6/pf0PhrDfoPUo4zH21POigUNN+Ji3vpAGfFALq0gtyZ/xN6xSmdEoGmE9ynjkHqhPz7gYJKZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776410800; c=relaxed/simple;
	bh=6z8KU3NCMbUT3OhZmEf1SYIWyHEsqj/J2MUIFTj1moU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=AR89/LzbVxjEnvtKICwPo2Q6BMLotJ0ZRbiF+WOsOuJxgLx636WQB4tSFNpfpkipNaJ6njYPvalwMLIqtUmOxqTU3NwjyWmDfQzcMBucJ7T2Qp2RJX4l69qKcOG1K+z7PvIkOk566UI6XAxWUv3g4xWEo9gFal3eIXf+jGIYJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pfRkGkcc; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 17 Apr 2026 09:26:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776410786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6z8KU3NCMbUT3OhZmEf1SYIWyHEsqj/J2MUIFTj1moU=;
	b=pfRkGkccTyn8UoXdC6PKPPlDBSbs6b6VvGT8U6Qg7X0ZT2eSAjTRdeI0z2DgOpiehT36sW
	GgJDGODwiTnLM1EbJ2MxYTktjGBFJ5G6G0eKanRUTRZyk1s0cV5aYsABIwNvxjwHrZw17K
	/neXIRr5TdE+u19m9NPvArgSQrIu3TY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Delene Tchio Romuald <delenetchior1@gmail.com>, gregkh@linuxfoundation.org
CC: error27@gmail.com, hansg@kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_0/5=5D_staging=3A_rtl8723bs=3A?=
 =?US-ASCII?Q?_fix_multiple_security_vulnerabilities?=
In-Reply-To: <20260417061048.62484-1-delenetchior1@gmail.com>
References: <20260417061048.62484-1-delenetchior1@gmail.com>
Message-ID: <71B54E47-F1DA-49A1-9742-3F70AA631607@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238437-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lists.linux.dev,vger.kernel.org,linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: A18B9417E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On April 17, 2026 8:10:43 AM GMT+02:00, Delene Tchio Romuald <delenetchior1=
@gmail=2Ecom> wrote:
>This series fixes five remotely-triggerable memory safety issues in
>the rtl8723bs driver=2E All of them are reachable from the air by an
>attacker within WiFi radio range, without authentication, via
>crafted management or data frames:
>

LGTM=2E
Reviewed-by: Luka Gejak <luka=2Egejak@linux=2Edev>

