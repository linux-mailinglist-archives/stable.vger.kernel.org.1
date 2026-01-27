Return-Path: <stable+bounces-211883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAWTDQ4HeWlrugEAu9opvQ
	(envelope-from <stable+bounces-211883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:42:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F59948E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E67830996E3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8993271F0;
	Tue, 27 Jan 2026 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L0IiS2OD"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B2329360
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539273; cv=none; b=mglAXO4Q124LRjs2HBQdhmtYfjWBCfNB7Mm9st4lCjj0WubJ5OKSPY8kVkpwAMfsWIFNC1c/id7K9KXbdvpZ+fHI9TvBp3QYiSsUwUqwUoGISrD0GjpJxw9aLlF97K+RSIkqiY25PwXmFELAXkFBh7Cq0oWYn3H2KMyVaUxvDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539273; c=relaxed/simple;
	bh=rkphZnMO8wHh8g0onFqCHga56Po/l8svJSB72PlZawU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rz5qsDxrwqipLJB6HaVIf/3zQvx/6xaUlnKGMkTa92MY4A4PP6Ej78EYwLi7w9j76JoB+kLtEvo0ccAVu3yYz1bos7jc1LQx0O15VuXqMyRJRnvQB9XD+ZSEtRl2Stxn+J0WRIgZyczeMBsuMsRds3FkEeXeypnzRaN9W6qGw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L0IiS2OD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 9A46F20B7165; Tue, 27 Jan 2026 10:41:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A46F20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769539272;
	bh=rkphZnMO8wHh8g0onFqCHga56Po/l8svJSB72PlZawU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0IiS2OD743ZCnNJphBIUIuJYGTIBX9vQFXx6mJyyJ/yOFfLstCcxYMOmLlbKHtni
	 GF+MoCf+uJ0Azhdsk4w5nttV4DisELZzT9KFkpOi60QJgozeTozpSwePDKXvbUxF9e
	 LG68HwhXP1MSv+sKSvCBYGP8h7kF4yJFbei2+eXQ=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: hamzamahfooz@linux.microsoft.com
Cc: cascardo@igalia.com,
	gregkh@linuxfoundation.org,
	lizhi.xu@windriver.com,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	tytso@mit.edu
Subject: Re: [PATCH 6.6 176/737] perf arm-spe: Extend branch operations
Date: Tue, 27 Jan 2026 10:41:12 -0800
Message-ID: <20260127184112.458449-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260127183706.458136-1-hamzamahfooz@linux.microsoft.com>
References: <20260127183706.458136-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211883-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,340581ba9dceb7e06fb3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B28F59948E
X-Rspamd-Action: no action

I replied to the wrong thread, please disregard this message.

