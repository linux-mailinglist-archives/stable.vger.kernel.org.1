Return-Path: <stable+bounces-90569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD32A9BE8FE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47548B215C8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2711DF726;
	Wed,  6 Nov 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YoNJdBUn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD81D2784;
	Wed,  6 Nov 2024 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896162; cv=none; b=GK2mnjwF9Vb3IgXUCvEOUJ0X0ffzKwbLQGJH1xJvRNE3y9Wg/N2OyWhSv1XtADl0LinbSqbxuI5GABbRJAjzXXceIjrNaa50f1xw8p8Z7Ub5OM+UBtZgNrTVHD2A79FO12UW5r/PpHHi1yE7VKQ2+4cJKD1RrONvRVsDuPIikL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896162; c=relaxed/simple;
	bh=Qth4LDcS4pMecX2nY+VzEDhHXRosx+7WS+tO25Ejxs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTM5I3adK1goKs4iHTKHq/ib5P6M1LNxGxqtIQ+sfjDwLoi4zel1u6FRd8/5IQIAT+cFIxV3IzTExqUcFPmDebNmH07X0iV67a3aSQsk+G4srwyIdOrmcT80XxrUN0icEvNIot26Cq/kHEFEHLaGtB1gm8O8UhzuHv+TDnjIaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YoNJdBUn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7B4C4CECD;
	Wed,  6 Nov 2024 12:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896161;
	bh=Qth4LDcS4pMecX2nY+VzEDhHXRosx+7WS+tO25Ejxs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoNJdBUnHMhjPYyuoDw9bDqeAax/2+EW1w8sTYBsLNefqTHwtl9oH8SJMQiYGg5xO
	 ajWhow7qdS6K1ob5sUAQtGoLLqfJU/jTyRg7n77LeSklOGhBgnJ8ucgSYB76guaseP
	 cPRgxiLBErWI7WXG2d8ya3XYt8zx19w0CpkzTjBM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 6.11 109/245] usb: typec: fix unreleased fwnode_handle in typec_port_register_altmodes()
Date: Wed,  6 Nov 2024 13:02:42 +0100
Message-ID: <20241106120321.902218564@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 9581acb91eaf5bbe70086bbb6fca808220d358ba upstream.

The 'altmodes_node' fwnode_handle is never released after it is no
longer required, which leaks the resource.

Add the required call to fwnode_handle_put() when 'altmodes_node' is no
longer required.

Cc: stable@vger.kernel.org
Fixes: 7b458a4c5d73 ("usb: typec: Add typec_port_register_altmodes()")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20241021-typec-class-fwnode_handle_put-v2-1-3281225d3d27@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/class.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2341,6 +2341,7 @@ void typec_port_register_altmodes(struct
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 



