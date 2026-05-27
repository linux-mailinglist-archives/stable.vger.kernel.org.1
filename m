Return-Path: <stable+bounces-254675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKh/FkNLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9165E9B4F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A897309C9E1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557A3B19D9;
	Wed, 27 May 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaZO8ylC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284E3B19D5
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911374; cv=none; b=Cgq/AcIjoInWo1Xt0ffq3D4W8cmQXc0fDYYsQoFyCrwbyzdOeCRJtQBpCt3gYrIfCcCDbtRbm7a30BX4Al9hHQhceoLm18bh6nRmZ8RjKS7MglpubJFadMWbhKaSlhEoaoZt7U47R9gdPFw+63lTbn/rFLSepcDXiNXmxje0gfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911374; c=relaxed/simple;
	bh=pu7xqlq2OaICPvGzPV5z7jHq+aFQ9JV6gbbIjqn2Q4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0ToM2HpSpYmbk7aqVACB/muYvQuzxruXuxkfnSyKAbV3TJCLCLex8j7HQu/kRgq+1DRFMu4BfmVXtX1stUR6O9ilmfQsz0mzVIKVihbkfKd2/pDwvE/fY8fuIa3vD32+/E7ujB0gfkpRyDR6kIkQZZ0EkoFUkGppeX339AOgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaZO8ylC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB771F000E9;
	Wed, 27 May 2026 19:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911373;
	bh=pu7xqlq2OaICPvGzPV5z7jHq+aFQ9JV6gbbIjqn2Q4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JaZO8ylC/5fvCdxaq7M7KTHvJeO8cMHqdjZM5ejBN11jH68kvmtn3I24WnNf8lBIW
	 z99ZtUjigIhQfT4bAxbrIu20fKv0oHAg2zdivxAHwvahxr1KdFPU+W2rmZVq3aj/D3
	 KwbSTVpC952x+UNfADfc7TlKXtsAlRhrgF6jwbHgP1rnllKg6yizJXaWO2vu2Xv5oA
	 LLv6KxLe0lXmPkTisccycJ9YPsh3kZOnWcDYOyUVz0631Kh83+YqLF3ArxiYxmFlYz
	 87jTyYhlNVi1DfVloB3JRSEBrS/S45fXxSJz7xyAsRYkLoh/GwTRJqhvHy5Eq8eAnK
	 5P4+kUEGPoSCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	pulehui@huawei.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bjorn@rivosinc.com,
	linux-riscv@lists.infradead.org,
	kernel test robot <lkp@intel.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] riscv: fgraph: Select HAVE_FUNCTION_GRAPH_TRACER depends on HAVE_DYNAMIC_FTRACE_WITH_ARGS
Date: Wed, 27 May 2026 15:49:07 -0400
Message-ID: <20260527-agent5-item015-riscv-kconfig@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192636.83171-1-gyokhan@amazon.de>
References: <20260526192636.83171-1-gyokhan@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254675-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1E9165E9B4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit e8eb8e1bdae94b9e003f5909519fd311d0936890 upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

