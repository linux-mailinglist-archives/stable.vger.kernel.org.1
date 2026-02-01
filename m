Return-Path: <stable+bounces-213008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GXrwGeavf2nWvwIAu9opvQ
	(envelope-from <stable+bounces-213008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 20:56:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E02C71D7
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 20:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2942230048CE
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 19:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4E2C21EC;
	Sun,  1 Feb 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIbeWjmf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C10279DC2
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 19:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769975775; cv=none; b=ANtQee+9fVYRya9NhCsSdhdnlT/BccJGHo5WN6xmhTJtuLdTFRtWzBaxzUeIxHQ8994XbJ3EBXYm95WwGTfTsbvxndKI6dIzuiI2GUK2WWi6JFquheqQibiC0s6nPg6pPKykRmJ1WjtolQd/FzDJWwriNdgE1+a16ggmrPij7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769975775; c=relaxed/simple;
	bh=Pwlx/J9MbOtPxsxZBOhkLEulnA+mVCEwhThJ11/j0kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBNzpi+Ck/B3hqA80RxfOIdU6TmSV+8g3fm5YU+ZZs0tNFKsxubIoKW6i3yxxRU9yEXcMiJLeLagESn8wNtwTV5Xk5jJ8k+kBl10EPeNIs7kXMbh8pufS6lCPrwCAxjtSAqG7nrjoqZDFW4sMulid0FLfGFXr9x2KGeR0dVNJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIbeWjmf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso16823105e9.2
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 11:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769975772; x=1770580572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9noXDr9PCECzEbfKECXdKZNREsy2QQwblXo7rhKIEZw=;
        b=MIbeWjmfXr1Tq5pqPwzLpuKUU2wyIVCurGQlCJTBo3LegF9BE5ZuNtQYnyGhw9BC+C
         PeXlplMWZle9pvq6oekEqmrJUeQMAkxZ7Hj5Oyrfq2TbvRpjjyKrDMlNJYYP+7jDbqdn
         x1tOmTU/MupIa7lHZLtLgIKrYT2Uv7PIDV7TPqFYRIlUnOyBQPf+PZkP5n9foxqdobRv
         0/vTC9WU+AAWbfkCRxytzYA8Krk8tzEF6JBlGZKVR3hhkSS4kS30Vv3QeQFpgYupmNME
         ZbEH3Mx+p3oGiZOCYDNDuoc4WvfE5FWJxyANfQ0tfqoHBOKn8nyfrfenVDFVRXrn48eH
         aRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769975772; x=1770580572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9noXDr9PCECzEbfKECXdKZNREsy2QQwblXo7rhKIEZw=;
        b=r2gea1+Rf7TjYj9xjlv3JrXX4k8YP7SrWQHkmL0rbzTW49RMoS27lqmpsbUtESAZDi
         a3vBhUH3SjPVEqJwhFjuB3LwzJPndAu6Caoe2Kpt7lRtlw/3Zn4NmN7Ry3OLBI+MT9ZL
         r0kUTJ4NUWHJ41LL0j+VIZKEJK8EIUdpdwJrvCZW+ZLDV+ep8xZ6laYVP0E1LXtxWH+2
         nUzMkXBnDk4MO4XX5MyJMMmKI5i3EKzt6y+bjc/VnyIU0QuYbYgHp7sYDSPS56RZnpgz
         BKsGrbosd/4/9oXiuod69qsPz3/LDz4EM1tdhUgXUDzL4Scqfwd//e2ddmz461vfsVZb
         3HBw==
X-Forwarded-Encrypted: i=1; AJvYcCWTmxcxhHlg+Ralu+q0pbHL+bD9dLHQHYIV07D4TY/Pd2wDsRDwFJ3MHIA6KApwy71uJlg+5D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZx32EHLZ0nKbfSbytGqS7fR/v9Q7zecXJ+ETznQKiGqY5mNF+
	2BXezG+xjYyG5YO5UPPdqygYJuXo951lX2WqMwSjw/fH7GrZnYeUX8CO
X-Gm-Gg: AZuq6aKmG0awMMgDKI5uSyxrvzjvoIwUkMNg1nwh2CTPhDhtIjlRSRMyDLAVwcld6Lx
	qwEUwkYldeZXf1SG3R0TICj9I3BvG6vGktT4XRrNfcgaOayCEwrOsw+fJaa3jMtbnTdKQFkPNpi
	EQyoX/yUvvRW1Rd6wF3dPXABCsmxik2GzT4l3MKIGNOR5zkwqULS/NO/SDdsc1EQQ01yKnj/oh6
	6mz6veBvLlBqg8VqXUVxfKmahsMniaOS+xl8vMWyyyu9QdIDz5i4bfhHwfldBgetOA7P4PMXxQe
	kG4rbIZ4yxKU0x8+bDXbaRrSh+4FAVA1Ke0itCCNS2gyJqawj/GQBufXWs7J/kgEWlIcSb1fPCF
	TN/Z3J7KdpevA/WCTn8H9b3GvDCLOo3Av60lBY9fYuHuzD+fKt7gxxujE3KyvRghEYGI55mkU6L
	esZ/1Z3R4=
X-Received: by 2002:a05:600c:354c:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-482db493ea9mr116560545e9.8.1769975772302;
        Sun, 01 Feb 2026 11:56:12 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4806cddffe9sm495503285e9.4.2026.02.01.11.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 11:56:11 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH v2 0/4] fs: add immutable rootfs
Date: Sun,  1 Feb 2026 22:55:31 +0300
Message-ID: <20260201195531.1480148-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213008-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,in.waw.pl];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: A6E02C71D7
X-Rspamd-Action: no action

Christian, important! Your patchset breaks userspace! (And I tested this.)

Christian Brauner <brauner@kernel.org>:
> Currently pivot_root() doesn't work on the real rootfs because it
> cannot be unmounted. Userspace has to do a recursive removal of the
> initramfs contents manually before continuing the boot.

listmount is buggy (see details below), but currently on a typical
Linux distro the bug is hidden. Your new nullfs patchset exposes the bug,
and now typical Linux configuration becomes buggy!

Look at this loop:
https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L5518 .

This loop is executed, when we call listmount on non-our namespace with
LSMT_ROOT.

As you can see, this loop finds mount, which is exactly one layer above
initial root mount. But why? What if our initial root mount was
overmounted multiple times?

What (in my opinion) is actually needed here is to find topmost overmount
of initial root mount. We know how to do this, we do this here:
https://elixir.bootlin.com/linux/v6.19-rc5/source/fs/namespace.c#L6096 .

Fortunately, current listmount code works in a typical configuration.
Usually we indeed overmount initramfs exactly one time.
So, listmount usually does the right thing.

But this nullfs patchset breaks listmount. Now on a typical distro
(we assume that initramfs implementations (i. e. dracut, etc) are not
yet changed to take advantage of nullfs) initial root mount (i. e. nullfs)
will be overmounted two times: initramfs and actual disk root fs.

So listmount with LSMT_ROOT in somebody's else namespace will return
initramfs instead of actual topmost root fs.

I think this listmount bug should be fixed before nullfs is applied to
mainline.

I tested listmount behavior I'm talking about. On both vfs.all (i. e. with
nullfs patches applied) and on some older vfs.git commit (without nullfs).

-- 
Askar Safin

