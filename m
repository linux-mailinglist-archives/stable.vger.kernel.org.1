Return-Path: <stable+bounces-50827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10228906CFC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237891C222A6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D71448FD;
	Thu, 13 Jun 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ZaVd5jZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E9143883;
	Thu, 13 Jun 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279502; cv=none; b=XI8uoMyKaG1NrDV3AX02cOHI5Dzipad1nSB7FR3TqZmyRl4gY0VfBXtJMb2w1kWHsrW6+NhMec4rQIU8aaVdXSuv0QikfGqC3OR5NIfaU0KasiBBDd/M7J8pXXd9+BlwFQBOU5SGlJ22NgSCEdy/MdCO8E/u7Qfuyx5wkq8DwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279502; c=relaxed/simple;
	bh=AjBqxcZr/dPxPFY7DYtK9n1JYV7ulz6ekBnxx0GJTco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM5iT1KxiWV9tpDzowxbe+Hj2/Cl6C2gK+IBC2vjMWxQ89YW6fNGIWqYlNed7meol7IC0YZI55Kcn/jZhSSRTb9teWBiJH7BOaa1M5qqxrrFInFyalkk6L58OpcKONkb79Gsn7d5RH609POCxx1PUYSaMuSBJQ9V6Jz+BvXgrKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ZaVd5jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB33C2BBFC;
	Thu, 13 Jun 2024 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279501;
	bh=AjBqxcZr/dPxPFY7DYtK9n1JYV7ulz6ekBnxx0GJTco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ZaVd5jZ7rLYTqKQgTlFV6cycNGN5/3dKxMkaUQv+qHrnUzaiuuO5NJBb2Vh0lx5+
	 rwo7PQAe0pE9Axtw7gAHBmRrEXzOecivDmcViwuzx7sfnVl+Dia5Nw5Ad1ybo20jtx
	 atbjmI043C6juqe6wjwNFXEqiUUlYqrqT2kmDKA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Beulich <jbeulich@suse.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 6.9 090/157] tpm_tis: Do *not* flush uninitialized work
Date: Thu, 13 Jun 2024 13:33:35 +0200
Message-ID: <20240613113230.907469894@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <jbeulich@suse.com>

commit 0ea00e249ca992adee54dc71a526ee70ef109e40 upstream.

tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
called, in which case tpm_tis_remove() unconditionally calling
flush_work() is triggering a warning for .func still being NULL.

Cc: stable@vger.kernel.org # v6.5+
Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_tis_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1020,7 +1020,8 @@ void tpm_tis_remove(struct tpm_chip *chi
 		interrupt = 0;
 
 	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
-	flush_work(&priv->free_irq_work);
+	if (priv->free_irq_work.func)
+		flush_work(&priv->free_irq_work);
 
 	tpm_tis_clkrun_enable(chip, false);
 



