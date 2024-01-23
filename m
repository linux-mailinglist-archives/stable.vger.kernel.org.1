Return-Path: <stable+bounces-14097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79545837F7C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C313B1F2402F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DE66280F;
	Tue, 23 Jan 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfJyfglJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E986627E5;
	Tue, 23 Jan 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971160; cv=none; b=SnwF3Lt4pcNwsRaEXysbmHZOno3MYFKJ6y8qsSuL6xmYLAD5aHOnUkFps+x/gmwWl03ietW8gZoWujOuHb1uFUKgzDv5xo7QLRUy1w3Uwa5RFNqiLs2UlxcfpGA+VT10q+ztXIdcXXcDIPCmxjDdyfnl5A9/MMfkwQwfDtz4IfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971160; c=relaxed/simple;
	bh=2vBzs+h5P7fbnuTYWnXAv3nqNf3FV3/HqcBc3erqqzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnG4euK28W5S2vIoj6S5iya/uANwWGg1lO+WyXJchP0ywrx38qs1vKfXJsbmbHOiUIb8t5r9VHtE/DeUshzJBJMcjALppoqnkS9oI/dYF7sGWfmaaw07Olc4PFhUeGfnzzHyct+G31kVARyUpqbBS2UBmZZXNJa/R0EdjzPoBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfJyfglJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAD8C433F1;
	Tue, 23 Jan 2024 00:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971160;
	bh=2vBzs+h5P7fbnuTYWnXAv3nqNf3FV3/HqcBc3erqqzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfJyfglJhzv7Ja4buXnPqtctLiEWyceonpbDqFeN/GhL6FyzJWHEyCl3btnICIP9p
	 jnx67hiAz9TQW6+xtDDNSJLF9Yue9KQsyvACby6I607VNWSdB1SCoeLh3TiU/gWDSQ
	 VHIpmQ7ct68pTNhR4bXBSkR1Zrydxl8jOsBiKc2A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	lei he <helei.sig11@bytedance.com>,
	zhenwei pi <pizhenwei@bytedance.com>,
	Gonglei <arei.gonglei@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10 079/286] virtio-crypto: implement RSA algorithm
Date: Mon, 22 Jan 2024 15:56:25 -0800
Message-ID: <20240122235735.084838403@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhenwei pi <pizhenwei@bytedance.com>

[ Upstream commit 59ca6c93387d325e96577d8bd4c23c78c1491c11 ]

Support rsa & pkcs1pad(rsa,sha1) with priority 150.

Test with QEMU built-in backend, it works fine.
1, The self-test framework of crypto layer works fine in guest kernel
2, Test with Linux guest(with asym support), the following script
test(note that pkey_XXX is supported only in a newer version of keyutils):
  - both public key & private key
  - create/close session
  - encrypt/decrypt/sign/verify basic driver operation
  - also test with kernel crypto layer(pkey add/query)

All the cases work fine.

rm -rf *.der *.pem *.pfx
modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
rm -rf /tmp/data
dd if=/dev/random of=/tmp/data count=1 bs=226

openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -subj "/C=CN/ST=BJ/L=HD/O=qemu/OU=dev/CN=qemu/emailAddress=qemu@qemu.org"
openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
openssl x509 -in cert.pem -inform PEM -outform DER -out cert.der

PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
echo "priv key id = "$PRIV_KEY_ID
PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
echo "pub key id = "$PUB_KEY_ID

keyctl pkey_query $PRIV_KEY_ID 0
keyctl pkey_query $PUB_KEY_ID 0

echo "Enc with priv key..."
keyctl pkey_encrypt $PRIV_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.priv
echo "Dec with pub key..."
keyctl pkey_decrypt $PRIV_KEY_ID 0 /tmp/enc.priv enc=pkcs1 >/tmp/dec
cmp /tmp/data /tmp/dec

echo "Sign with priv key..."
keyctl pkey_sign $PRIV_KEY_ID 0 /tmp/data enc=pkcs1 hash=sha1 > /tmp/sig
echo "Verify with pub key..."
keyctl pkey_verify $PRIV_KEY_ID 0 /tmp/data /tmp/sig enc=pkcs1 hash=sha1

echo "Enc with pub key..."
keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
echo "Dec with priv key..."
keyctl pkey_decrypt $PRIV_KEY_ID 0 /tmp/enc.pub enc=pkcs1 >/tmp/dec
cmp /tmp/data /tmp/dec

echo "Verify with pub key..."
keyctl pkey_verify $PUB_KEY_ID 0 /tmp/data /tmp/sig enc=pkcs1 hash=sha1

[1 compiling warning during development]
Reported-by: kernel test robot <lkp@intel.com>

Co-developed-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Link: https://lore.kernel.org/r/20220302033917.1295334-4-pizhenwei@bytedance.com
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org> #Kconfig tweaks
Link: https://lore.kernel.org/r/20220308205309.2192502-1-nathan@kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: fed93fb62e05 ("crypto: virtio - Handle dataq logic with tasklet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/Kconfig                 |   3 +
 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
 6 files changed, 608 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c

diff --git a/drivers/crypto/virtio/Kconfig b/drivers/crypto/virtio/Kconfig
index b894e3a8be4f..5f8915f4a9ff 100644
--- a/drivers/crypto/virtio/Kconfig
+++ b/drivers/crypto/virtio/Kconfig
@@ -3,8 +3,11 @@ config CRYPTO_DEV_VIRTIO
 	tristate "VirtIO crypto driver"
 	depends on VIRTIO
 	select CRYPTO_AEAD
+	select CRYPTO_AKCIPHER2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ENGINE
+	select CRYPTO_RSA
+	select MPILIB
 	help
 	  This driver provides support for virtio crypto device. If you
 	  choose 'M' here, this module will be called virtio_crypto.
diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
index cbfccccfa135..f2b839473d61 100644
--- a/drivers/crypto/virtio/Makefile
+++ b/drivers/crypto/virtio/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
 virtio_crypto-objs := \
 	virtio_crypto_algs.o \
+	virtio_crypto_akcipher_algs.o \
 	virtio_crypto_mgr.o \
 	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
new file mode 100644
index 000000000000..f3ec9420215e
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+ /* Asymmetric algorithms supported by virtio crypto device
+  *
+  * Authors: zhenwei pi <pizhenwei@bytedance.com>
+  *          lei he <helei.sig11@bytedance.com>
+  *
+  * Copyright 2022 Bytedance CO., LTD.
+  */
+
+#include <linux/mpi.h>
+#include <linux/scatterlist.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <linux/err.h>
+#include <crypto/scatterwalk.h>
+#include <linux/atomic.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+struct virtio_crypto_rsa_ctx {
+	MPI n;
+};
+
+struct virtio_crypto_akcipher_ctx {
+	struct crypto_engine_ctx enginectx;
+	struct virtio_crypto *vcrypto;
+	struct crypto_akcipher *tfm;
+	bool session_valid;
+	__u64 session_id;
+	union {
+		struct virtio_crypto_rsa_ctx rsa_ctx;
+	};
+};
+
+struct virtio_crypto_akcipher_request {
+	struct virtio_crypto_request base;
+	struct virtio_crypto_akcipher_ctx *akcipher_ctx;
+	struct akcipher_request *akcipher_req;
+	void *src_buf;
+	void *dst_buf;
+	uint32_t opcode;
+};
+
+struct virtio_crypto_akcipher_algo {
+	uint32_t algonum;
+	uint32_t service;
+	unsigned int active_devs;
+	struct akcipher_alg algo;
+};
+
+static DEFINE_MUTEX(algs_lock);
+
+static void virtio_crypto_akcipher_finalize_req(
+	struct virtio_crypto_akcipher_request *vc_akcipher_req,
+	struct akcipher_request *req, int err)
+{
+	virtcrypto_clear_request(&vc_akcipher_req->base);
+
+	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
+}
+
+static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *vc_req, int len)
+{
+	struct virtio_crypto_akcipher_request *vc_akcipher_req =
+		container_of(vc_req, struct virtio_crypto_akcipher_request, base);
+	struct akcipher_request *akcipher_req;
+	int error;
+
+	switch (vc_req->status) {
+	case VIRTIO_CRYPTO_OK:
+		error = 0;
+		break;
+	case VIRTIO_CRYPTO_INVSESS:
+	case VIRTIO_CRYPTO_ERR:
+		error = -EINVAL;
+		break;
+	case VIRTIO_CRYPTO_BADMSG:
+		error = -EBADMSG;
+		break;
+
+	case VIRTIO_CRYPTO_KEY_REJECTED:
+		error = -EKEYREJECTED;
+		break;
+
+	default:
+		error = -EIO;
+		break;
+	}
+
+	akcipher_req = vc_akcipher_req->akcipher_req;
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
+				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
+}
+
+static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
+		struct virtio_crypto_ctrl_header *header, void *para,
+		const uint8_t *key, unsigned int keylen)
+{
+	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	uint8_t *pkey;
+	unsigned int inlen;
+	int err;
+	unsigned int num_out = 0, num_in = 0;
+
+	pkey = kmemdup(key, keylen, GFP_ATOMIC);
+	if (!pkey)
+		return -ENOMEM;
+
+	spin_lock(&vcrypto->ctrl_lock);
+	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
+	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
+	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+
+	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&key_sg, pkey, keylen);
+	sgs[num_out++] = &key_sg;
+
+	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0)
+		goto out;
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_valid = true;
+	err = 0;
+
+out:
+	spin_unlock(&vcrypto->ctrl_lock);
+	kfree_sensitive(pkey);
+
+	if (err < 0)
+		pr_err("virtio_crypto: Create session failed status: %u\n",
+			le32_to_cpu(vcrypto->input.status));
+
+	return err;
+}
+
+static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
+{
+	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
+	struct virtio_crypto_destroy_session_req *destroy_session;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	unsigned int num_out = 0, num_in = 0, inlen;
+	int err;
+
+	spin_lock(&vcrypto->ctrl_lock);
+	if (!ctx->session_valid) {
+		err = 0;
+		goto out;
+	}
+	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	vcrypto->ctrl.header.queue_id = 0;
+
+	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session->session_id = cpu_to_le64(ctx->session_id);
+
+	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0)
+		goto out;
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = 0;
+	ctx->session_valid = false;
+
+out:
+	spin_unlock(&vcrypto->ctrl_lock);
+	if (err < 0) {
+		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
+			vcrypto->ctrl_status.status, destroy_session->session_id);
+	}
+
+	return err;
+}
+
+static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
+		struct akcipher_request *req, struct data_queue *data_vq)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
+	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
+	void *src_buf = NULL, *dst_buf = NULL;
+	unsigned int num_out = 0, num_in = 0;
+	int node = dev_to_node(&vcrypto->vdev->dev);
+	unsigned long flags;
+	int ret = -ENOMEM;
+	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
+	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
+
+	/* out header */
+	sg_init_one(&outhdr_sg, req_data, sizeof(*req_data));
+	sgs[num_out++] = &outhdr_sg;
+
+	/* src data */
+	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
+	if (!src_buf)
+		goto err;
+
+	if (verify) {
+		/* for verify operation, both src and dst data work as OUT direction */
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+	} else {
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+
+		/* dst data */
+		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
+		if (!dst_buf)
+			goto err;
+
+		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
+		sgs[num_out + num_in++] = &dstdata_sg;
+	}
+
+	vc_akcipher_req->src_buf = src_buf;
+	vc_akcipher_req->dst_buf = dst_buf;
+
+	/* in header */
+	sg_init_one(&inhdr_sg, &vc_req->status, sizeof(vc_req->status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	spin_lock_irqsave(&data_vq->lock, flags);
+	ret = virtqueue_add_sgs(data_vq->vq, sgs, num_out, num_in, vc_req, GFP_ATOMIC);
+	virtqueue_kick(data_vq->vq);
+	spin_unlock_irqrestore(&data_vq->lock, flags);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(src_buf);
+	kfree(dst_buf);
+
+	return -ENOMEM;
+}
+
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+{
+	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct data_queue *data_vq = vc_req->dataq;
+	struct virtio_crypto_op_header *header;
+	struct virtio_crypto_akcipher_data_req *akcipher_req;
+	int ret;
+
+	vc_req->sgs = NULL;
+	vc_req->req_data = kzalloc_node(sizeof(*vc_req->req_data),
+		GFP_KERNEL, dev_to_node(&vcrypto->vdev->dev));
+	if (!vc_req->req_data)
+		return -ENOMEM;
+
+	/* build request header */
+	header = &vc_req->req_data->header;
+	header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
+	header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header->session_id = cpu_to_le64(ctx->session_id);
+
+	/* build request akcipher data */
+	akcipher_req = &vc_req->req_data->u.akcipher_req;
+	akcipher_req->para.src_data_len = cpu_to_le32(req->src_len);
+	akcipher_req->para.dst_data_len = cpu_to_le32(req->dst_len);
+
+	ret = __virtio_crypto_akcipher_do_req(vc_akcipher_req, req, data_vq);
+	if (ret < 0) {
+		kfree_sensitive(vc_req->req_data);
+		vc_req->req_data = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
+{
+	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	/* Use the first data virtqueue as default */
+	struct data_queue *data_vq = &vcrypto->data_vq[0];
+
+	vc_req->dataq = data_vq;
+	vc_req->alg_cb = virtio_crypto_dataq_akcipher_callback;
+	vc_akcipher_req->akcipher_ctx = ctx;
+	vc_akcipher_req->akcipher_req = req;
+	vc_akcipher_req->opcode = opcode;
+
+	return crypto_transfer_akcipher_request_to_engine(data_vq->engine, req);
+}
+
+static int virtio_crypto_rsa_encrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_ENCRYPT);
+}
+
+static int virtio_crypto_rsa_decrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
+}
+
+static int virtio_crypto_rsa_sign(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
+}
+
+static int virtio_crypto_rsa_verify(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
+}
+
+static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
+				     const void *key,
+				     unsigned int keylen,
+				     bool private,
+				     int padding_algo,
+				     int hash_algo)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+	struct virtio_crypto *vcrypto;
+	struct virtio_crypto_ctrl_header header;
+	struct virtio_crypto_akcipher_session_para para;
+	struct rsa_key rsa_key = {0};
+	int node = virtio_crypto_get_current_node();
+	uint32_t keytype;
+	int ret;
+
+	/* mpi_free will test n, just free it. */
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+
+	if (private) {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+		ret = rsa_parse_priv_key(&rsa_key, key, keylen);
+	} else {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
+	}
+
+	if (ret)
+		return ret;
+
+	rsa_ctx->n = mpi_read_raw_data(rsa_key.n, rsa_key.n_sz);
+	if (!rsa_ctx->n)
+		return -ENOMEM;
+
+	if (!ctx->vcrypto) {
+		vcrypto = virtcrypto_get_dev_node(node, VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+						VIRTIO_CRYPTO_AKCIPHER_RSA);
+		if (!vcrypto) {
+			pr_err("virtio_crypto: Could not find a virtio device in the system or unsupported algo\n");
+			return -ENODEV;
+		}
+
+		ctx->vcrypto = vcrypto;
+	} else {
+		virtio_crypto_alg_akcipher_close_session(ctx);
+	}
+
+	/* set ctrl header */
+	header.opcode =	cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION);
+	header.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header.queue_id = 0;
+
+	/* set RSA para */
+	para.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	para.keytype = cpu_to_le32(keytype);
+	para.keylen = cpu_to_le32(keylen);
+	para.u.rsa.padding_algo = cpu_to_le32(padding_algo);
+	para.u.rsa.hash_algo = cpu_to_le32(hash_algo);
+
+	return virtio_crypto_alg_akcipher_init_session(ctx, &header, &para, key, keylen);
+}
+
+static int virtio_crypto_rsa_raw_set_priv_key(struct crypto_akcipher *tfm,
+					      const void *key,
+					      unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+
+static int virtio_crypto_p1pad_rsa_sha1_set_priv_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static int virtio_crypto_rsa_raw_set_pub_key(struct crypto_akcipher *tfm,
+					     const void *key,
+					     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+static int virtio_crypto_p1pad_rsa_sha1_set_pub_key(struct crypto_akcipher *tfm,
+						    const void *key,
+						    unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static unsigned int virtio_crypto_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	return mpi_get_size(rsa_ctx->n);
+}
+
+static int virtio_crypto_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->tfm = tfm;
+	ctx->enginectx.op.do_one_request = virtio_crypto_rsa_do_req;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void virtio_crypto_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	virtio_crypto_alg_akcipher_close_session(ctx);
+	virtcrypto_dev_put(ctx->vcrypto);
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+}
+
+static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.set_pub_key = virtio_crypto_rsa_raw_set_pub_key,
+			.set_priv_key = virtio_crypto_rsa_raw_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "rsa",
+				.cra_driver_name = "virtio-crypto-rsa",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.sign = virtio_crypto_rsa_sign,
+			.verify = virtio_crypto_rsa_verify,
+			.set_pub_key = virtio_crypto_p1pad_rsa_sha1_set_pub_key,
+			.set_priv_key = virtio_crypto_p1pad_rsa_sha1_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "pkcs1pad(rsa,sha1)",
+				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+};
+
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
+{
+	int ret = 0;
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (!virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0) {
+			ret = crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+			if (ret)
+				goto unlock;
+		}
+
+		virtio_crypto_akcipher_algs[i].active_devs++;
+		dev_info(&vcrypto->vdev->dev, "Registered akcipher algo %s\n",
+			 virtio_crypto_akcipher_algs[i].algo.base.cra_name);
+	}
+
+unlock:
+	mutex_unlock(&algs_lock);
+	return ret;
+}
+
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto)
+{
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
+		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
+			crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+
+		virtio_crypto_akcipher_algs[i].active_devs--;
+	}
+
+	mutex_unlock(&algs_lock);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index a24f85c589e7..214f9a6fcf84 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -56,6 +56,7 @@ struct virtio_crypto {
 	u32 mac_algo_l;
 	u32 mac_algo_h;
 	u32 aead_algo;
+	u32 akcipher_algo;
 
 	/* Maximum length of cipher key */
 	u32 max_cipher_key_len;
@@ -131,5 +132,7 @@ static inline int virtio_crypto_get_current_node(void)
 
 int virtio_crypto_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 080955a1dd9c..f6eb6d064fbd 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -297,6 +297,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	u32 mac_algo_l = 0;
 	u32 mac_algo_h = 0;
 	u32 aead_algo = 0;
+	u32 akcipher_algo = 0;
 	u32 crypto_services = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -348,6 +349,9 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 			mac_algo_h, &mac_algo_h);
 	virtio_cread_le(vdev, struct virtio_crypto_config,
 			aead_algo, &aead_algo);
+	if (crypto_services & (1 << VIRTIO_CRYPTO_SERVICE_AKCIPHER))
+		virtio_cread_le(vdev, struct virtio_crypto_config,
+				akcipher_algo, &akcipher_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
@@ -374,7 +378,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	vcrypto->mac_algo_h = mac_algo_h;
 	vcrypto->hash_algo = hash_algo;
 	vcrypto->aead_algo = aead_algo;
-
+	vcrypto->akcipher_algo = akcipher_algo;
 
 	dev_info(&vdev->dev,
 		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index 6860f8180c7c..1cb92418b321 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -242,6 +242,12 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 		return -EFAULT;
 	}
 
+	if (virtio_crypto_akcipher_algs_register(vcrypto)) {
+		pr_err("virtio_crypto: Failed to register crypto akcipher algs\n");
+		virtio_crypto_algs_unregister(vcrypto);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
@@ -258,6 +264,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
 {
 	virtio_crypto_algs_unregister(vcrypto);
+	virtio_crypto_akcipher_algs_unregister(vcrypto);
 }
 
 /*
@@ -312,6 +319,10 @@ bool virtcrypto_algo_is_supported(struct virtio_crypto *vcrypto,
 	case VIRTIO_CRYPTO_SERVICE_AEAD:
 		algo_mask = vcrypto->aead_algo;
 		break;
+
+	case VIRTIO_CRYPTO_SERVICE_AKCIPHER:
+		algo_mask = vcrypto->akcipher_algo;
+		break;
 	}
 
 	if (!(algo_mask & (1u << algo)))
-- 
2.43.0




