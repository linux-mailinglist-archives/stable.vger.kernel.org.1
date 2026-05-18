Return-Path: <stable+bounces-249219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LZ8CEbNCmq18QQAu9opvQ
	(envelope-from <stable+bounces-249219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:26:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A3568B71
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 10:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619E13010F17
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7C63E277F;
	Mon, 18 May 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrE7ZGzt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42C3E276A;
	Mon, 18 May 2026 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092108; cv=none; b=TYYoZhCgDGb4nhWJK9pcnxerHVrkLX5NgHHPpRQjU752jp72OGim5N0IEMJB5m3W8UZftrzLLzv25YZemBdo6pj9qZu+/cqplk8m0ANUEkrL5P56jWxHY/9Fr3LoEc2zQz4O9xDbL/dLFFENb+fCvrknO3IVeQf88nbjBcHSF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092108; c=relaxed/simple;
	bh=03y1ZTW9G/BytRAviEq6s7RpV7ovG3W3nN8jwCgUR70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNEQH5UElnoMQ/QX13ikCQVgnbyI3uczw3nMHUhFAfVN8K7yh31jthFjKuPyW7IEdSs7lzIFYFOdtu3ifExo1NPY2gM3hXW16nuL8PPD5e+7zsuogDj6pCk9Uqp9vtAo7xSOFnkli1ZvqkIyTUxbze7dXubLQv28J9EdwjlM/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrE7ZGzt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779092106; x=1810628106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=03y1ZTW9G/BytRAviEq6s7RpV7ovG3W3nN8jwCgUR70=;
  b=jrE7ZGzthvnHGE04nwY7u6xd0Ish7VoHehe7mx34cSdmPWndrFdzo+OI
   vOuUWl+GkeNcvZaa7MLJ7fpQN9dQQTWsBFytItwTpCvAeaC+YEbbVZvMS
   rl5AuwBvwhxaCNyco9CBEeYxq5cXUtLolE+yMMg7FSW0uCdIpJ7wyzTGf
   WDu8c58ROMjeUfY5XpZYhO7CBD4BxupZESvTQ/PhTmxFCX0ETkUUAj021
   XmUOYW0+QGkzKe1osOYDUrOpJbrzJj4fVpRknjZ8xFHfcZ0lzNbZ3ZmPc
   LVZzg3EszdXdJaoL3DkERKPem0e9mRfleeU7/2Tiaf6M/vKrBWX66d6e7
   Q==;
X-CSE-ConnectionGUID: HghaRUO4RduAYkqWkn07vg==
X-CSE-MsgGUID: BrZkjRXEQ+aH3kHMFEknxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79792362"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79792362"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:15:05 -0700
X-CSE-ConnectionGUID: MAGe3PucTWecG6MXjfkVIQ==
X-CSE-MsgGUID: ZU1fDBTrTW+hYKY/CaBnNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="263137490"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:15:03 -0700
Date: Mon, 18 May 2026 11:15:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>, andy@kernel.org,
	hcazarim@yahoo.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length
 message_store()
Message-ID: <agrKhHqSfKIb0N2o@ashevche-desk.local>
References: <20260514174342.28451-1-sozdayvek@gmail.com>
 <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
 <CAMuHMdUahvn5dr-sdN=4GP+0Mc2usG4CqVxYqkkzZz5RJbqZsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUahvn5dr-sdN=4GP+0Mc2usG4CqVxYqkkzZz5RJbqZsQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Queue-Id: 320A3568B71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249219-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,ashevche-desk.local:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 10:08:07AM +0200, Geert Uytterhoeven wrote:
> On Fri, 15 May 2026 at 09:13, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, May 14, 2026 at 8:44 PM Stepan Ionichev <sozdayvek@gmail.com> wrote:
> > > linedisp_display() unconditionally reads msg[count - 1] before
> > > checking whether count is zero, so a write of zero bytes to the
> > > message sysfs attribute hits msg[-1]:
> > >
> > >         write(fd, "", 0);
> > >
> > >         -> message_store(..., buf, count=0)
> > >            -> linedisp_display(linedisp, buf, count=0)
> > >               -> msg[count - 1] == '\n'  ; OOB read
> > >
> > > The kernfs write buffer for that store is a 1-byte allocation
> > > (kernfs_fop_write_iter() does kmalloc(len + 1) with len == 0),
> > > so msg[-1] is a 1-byte read before the slab object. On a
> > > KASAN-enabled kernel this trips an out-of-bounds report and
> > > panics; on stock kernels it silently reads adjacent slab data
> > > and, if that byte happens to be '\n', the following count--
> > > wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().
> > >
> > > linedisp_display() is reached from the message_store() sysfs
> > > callback (drivers/auxdisplay/line-display.c message attribute,
> > > mode 0644) and from the in-tree initial-message setup with
> > > count == -1, so the OOB path is only userspace-triggerable via
> > > zero-byte writes;
> >
> > Isn't it also triggerable when  PANEL_BOOT_MESSAGE is left default
> > with PANEL_CHANGE_MESSAGE="y"? (However these double quotes makes me
> > wonder if this even works, as usually we compare symbols against plain
> > 'n'. 'm', or 'y' (without any quotes).
> >
> > > vfs_write() does not short-circuit on
> > > count == 0 and kernfs_fop_write_iter() dispatches the store
> > > callback regardless.
> 
> I think PANEL_BOOT_MESSAGE is the only way to trigger this, as
> writing an empty string to a device attribute is a no-op according
> to commit afcb5a811ff3ab39 ("auxdisplay: img-ascii-lcd: Fix lock-up
> when displaying empty string")? If that is still true, the issue
> was introduced by commit c8ffef985af564c1 ("auxdisplay: linedisp:
> Support configuring the boot message")?

Good points. Should I drop the patch and ask for a new commit message
(and Fixes tag)?

-- 
With Best Regards,
Andy Shevchenko



