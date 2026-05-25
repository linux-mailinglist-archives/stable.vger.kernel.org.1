Return-Path: <stable+bounces-254174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAh8IpZsFGoTNQcAu9opvQ
	(envelope-from <stable+bounces-254174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70B5CC5F1
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A48AF304C7CF
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478BF3AD510;
	Mon, 25 May 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6N4GKRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773182E8B82;
	Mon, 25 May 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723207; cv=none; b=ImA/lWiwhBqqBAfi4qqo4c38q1/eOyvqY2B6YlZc2tKtVoXY4+PCBxS5PZX3xOLUjM0hRIzhNop4KxH6/dLfGYGlrLXE29FXCi278+ynj6OMHPnDOruEBoGjBqMNHeZQO3pEtVovfaiTbMwWiwShJnbPnngN9HMwANNRQKluqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723207; c=relaxed/simple;
	bh=V/mMUdKG7Dw2eSh64+XrQ9nf4Ts7EfkwSJK9b/P+Ml0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bl0si3Jr0buV/OICvwzjJYG9IKVupdtp351NUgVmJoHXwxTv1SEiqMgrRhGd6tLiezuc7YqpeKN9W0xIAhFaMPPgDsTtw7rI/fi7bN0Y2WuJWDMXlA9umXRcYPaSSJi+43NFuzRgJ58Jbh/u2P1uARyj40aSeF8ofLuct4J1Zv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6N4GKRj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6F51F00A3E;
	Mon, 25 May 2026 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723205;
	bh=q8Ikp1pIkOzEO2DqZfmRNUHDhWCAM595jcMat0Ka2jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6N4GKRj/1LcuELFDVv3RmCDaA9pu4YzJGU/rW2uUphIpZLKjDJ0sW+Z++lH9iiBf
	 LJnq5TknP0h9xFS85tVUkVbLTy5CN1CSu6fFCiNktnxpttnN8fR7lmTwo2NZ9+C4NO
	 FOogDTBz14qc+MELfo7N1ja4YAIG08qaolLuS9sDPnKEkt/YzPrtWXxx/UwLCtVZUo
	 X4yhrBHYDSCc0kasPoa9Svm5yPpxc4HK/huH1eLo1qCIZfx2aWGb2KSFmn79JhLgln
	 1xTxY/TrstidfzjkPjctXMOMqwLS75X7Yq8RfrGvh6zL89UTGtq9YXQ/OxZykDMUy4
	 Oiuk9EnLXEyBQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	alison.schofield@intel.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	Fang Wang <32840572@qq.com>
Subject: Re: [PATCH 6.6.y] cxl/port: Fix use after free of parent_port in cxl_detach_ep()
Date: Mon, 25 May 2026 11:33:10 -0400
Message-ID: <20260525152512.agent5-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_C9D9ED71D51B177EDF71B708417942F4F206@qq.com>
References: <tencent_C9D9ED71D51B177EDF71B708417942F4F206@qq.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254174-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,stgolabs.net,huawei.com,intel.com,zohomail.com,qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 0A70B5CC5F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 03:44:54PM +0800, Fang Wang wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>
> [ Upstream commit 19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4 ]
>
> @@ -527,6 +527,7 @@ static void cxl_port_release(struct device *dev)
>  	xa_destroy(&port->dports);
>  	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
> +	put_device(dev->parent);
>  	kfree(port);
>  }
>
> @@ -657,6 +658,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		struct cxl_port *iter;
>
>  		dev->parent = &parent_port->dev;
> +		get_device(dev->parent);
>  		port->depth = parent_port->depth + 1;
>  		port->parent_dport = parent_dport;

This isn't safe as-is for 6.6. Upstream guards the put_device() in
cxl_port_release() with is_cxl_root(port), and only does the matching
get_device() on the child-port path. In 6.6, struct cxl_root does not
exist yet (it was added in v6.8 by commit 26064b3641c4 ("cxl: introduce
cxl_root")) and the is_cxl_root() helper is absent, so dropping the
guard means cxl_port_release() unconditionally puts dev->parent.

cxl_port_alloc() in 6.6 only takes the new get_device(dev->parent) on
the parent_dport != NULL branch; the root-port path still does
`dev->parent = uport_dev` with no matching get. The result is an
unbalanced put on the root port's uport_dev (typically the cxl_acpi
host device) on every cxl_acpi unload, which is a fresh refcount
underflow / UAF on 6.6.

-- 
Thanks,
Sasha

