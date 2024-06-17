Return-Path: <stable+bounces-52364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2E90A920
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DFF1C2168D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CC3190694;
	Mon, 17 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hE5SZ4X0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672B1836FC
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615370; cv=none; b=eMpBbZ18Tjf/1OH71WI+le0/kcQDeyS5mEOcgoPU0vA1GWEWNg/EkjPMjKw+U+jg3Arff+olILxbRbJRq6PMgKqRallYxTZExiD1B6HHx0nHwo1pI4aLBl9moNO3IN1FZQHtg8rGSWfpUquvvD5RaJHP9tPao5MOAMfGzL8ERnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615370; c=relaxed/simple;
	bh=dKkNMZ+F+RnVioBr1IntSvVO9lxx9IMOF+2Uusx6fB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C9idDVHjd+INpdEQnwP1VAUUSIfQrkD8hi7THwCT5z1t8ZlW0hKjQ/oll9XTv5Z6ncQJ/eVhOLN/zDsSVIUgB2zF6t1wv+1y/URaZRda/M19JCT+WHUjYDYizEOH0Tx6XdAMnRG4ylsgNJQC9ie+i7oO8OOPKogp69o0AONr0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hE5SZ4X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D831C2BD10;
	Mon, 17 Jun 2024 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615369;
	bh=dKkNMZ+F+RnVioBr1IntSvVO9lxx9IMOF+2Uusx6fB0=;
	h=Subject:To:Cc:From:Date:From;
	b=hE5SZ4X0ZK0JMUm+0EHNbJwzlqBh2IIdQJ9FSu7yil8sdB1DlecLUXPCgJONNZvyd
	 zexkZauhdS62dxEmXVkUSJZ5hl1Z3/1ytQUezEvlgW4Hf8y8khj+p81NV4tquXNYuE
	 ND4bAhWIqP09oWNo8JmN86ZXDETwQW9AQdgIHXBM=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Ack also failed Get Error commands" failed to apply to 6.6-stable tree
To: heikki.krogerus@linux.intel.com,ammy.yi@intel.com,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:09:21 +0200
Message-ID: <2024061721-lankiness-both-b5bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdf8a42bca4f47646fd105a387ab6926948c7f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061721-lankiness-both-b5bd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

8bdf8a42bca4 ("usb: typec: ucsi: Ack also failed Get Error commands")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bdf8a42bca4f47646fd105a387ab6926948c7f1 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Fri, 31 May 2024 13:46:52 +0300
Subject: [PATCH] usb: typec: ucsi: Ack also failed Get Error commands

It is possible that also the GET_ERROR command fails. If
that happens, the command completion still needs to be
acknowledged. Otherwise the interface will be stuck until
it's reset.

Reported-by: Ammy Yi <ammy.yi@intel.com>
Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240531104653.1303519-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5..2cc7aedd490f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -153,8 +153,13 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS)
+		if (cmd == UCSI_GET_ERROR_STATUS) {
+			ret = ucsi_acknowledge(ucsi, false);
+			if (ret)
+				return ret;
+
 			return -EIO;
+		}
 		return ucsi_read_error(ucsi);
 	}
 


