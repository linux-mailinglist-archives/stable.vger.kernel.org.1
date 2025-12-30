Return-Path: <stable+bounces-204228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC43CE9F5F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA7C6300F197
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFB2EBB8C;
	Tue, 30 Dec 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="flPCAe66"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14502DF126
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105874; cv=none; b=VR+n0OJjRU87UB/q4skrFb9P1A6sriDw1ERmRnb0dRxVCaVcu91JFDqDjeLxscczs+fyOsrQYYB3KpWlvQkj6W+QqhJ4gqEAC4V8NoAVqrLduTCG5DcVgiOvwpLBkC5ozTmi418eK0A2CB7MnEvFhg5fI/0tmQXxWAUBGFEtXhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105874; c=relaxed/simple;
	bh=EIwQOV10OcAP5pNsnWkV+RTYtTuAt6gOMGBKc+nblTk=;
	h=Mime-Version:References:Content-Type:To:Date:Cc:Subject:From:
	 Message-Id:In-Reply-To; b=UoUkZYD1LpZ++YsEHfb5/ynJZ5A9M+62a8y5eKGFoG5vhxkQOBc2lqLESzpCG4DlAiDbGG7JeiCyBxWdwM71QRnRfr8DVxdJ27pLcup4Vsgy3XlhOjK6d23cl21z3HsSdiPsepiDPEibJEvhZMEayu5WImJIcsqGhU3dW0sQiGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=flPCAe66; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1767105862; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3caes/t6/vMlhVeEdZbXTwKTwEfyM8QU/5arWXZpPc4=;
 b=flPCAe66uf2QWzDxqni5kI25Gd3H5aaJPOnCkGUGLrd/VgLq6lw9nKsjUTQE0YSZXi02v4
 Zqs7qmsV5ZpHlrzuoX69vFY1aUsLelAPWHnEFN11tS31Y+vHtKAHaCco4cAAKItRa0cTDf
 IUPbSaIQHcqVp7xkBVmhhxreMjZRx10wCGGryXtpKO6HvzCRcVlu1VnaHHwh9zojhFQmFR
 bQVXzOUNRnkG1BzmWx1DXwkCDGLhiWPVovDNL5wYWcasjuFZmgLEKUE13vXE6MI7WMrc5m
 hUoZOSAVAFOOsAAyPkFlHB6za+aGHxl71Qmqkup2XPMZ5rsI2qMRfn4MJy3EtQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251230142736.1168-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <guojinhui.liam@bytedance.com>
Date: Tue, 30 Dec 2025 22:44:05 +0800
X-Lms-Return-Path: <lba+26953e544+07dee6+vger.kernel.org+guojinhui.liam@bytedance.com>
Cc: <alexander.h.duyck@linux.intel.com>, <bhelgaas@google.com>, 
	<bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <stable@vger.kernel.org>, <tj@kernel.org>
Subject: Re: [PATCH] PCI: Avoid work_on_cpu() in async probe workers
Content-Transfer-Encoding: quoted-printable
X-Mailer: git-send-email 2.17.1
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Message-Id: <20251230144405.1251-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20251230142736.1168-1-guojinhui.liam@bytedance.com>

On Tue, Dec 30, 2025 at 22:27:36PM +0800, Jinhui Guo wrote
> 2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_work=
()
>    to enable parallel probing when PROBE_PREFER_ASYNCHRONOUS is disabled.

Sorry for the mis-statement=E2=80=94probing is serial, not parallel:

2. Replace work_on_cpu() with queue_work_node(system_dfl_wq) + flush_work()
   to enable serial probing when PROBE_PREFER_ASYNCHRONOUS is disabled.

Thanks,
Jinhui

